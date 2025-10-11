#include <TFile.h>
#include <TTree.h>
#include <TH1F.h>
#include <TH2F.h>
#include <TCanvas.h>
#include <TStyle.h>
#include <TLegend.h>
#include <TGraph.h>
#include <TAxis.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

void abs_error_vs_rank() {
    // ==================== PARAMETERS ====================
    // Input file
    const char* inputCSV = "/home/work1/Work/CNN_iCube_FPGA_b/out/error_analysis/level_a_comparison_20251010_155810.csv";

    // Output files
    const char* outputROOT = "/home/work1/Work/CNN_iCube_FPGA_b/analysis/output/error_analysis.root";
    const char* outputPDF = "/home/work1/Work/CNN_iCube_FPGA_b/analysis/output/error_analysis.pdf";

    // Histogram parameters
    const int nBinsRank = 100;           // Number of bins for Rank
    const double rankMin = 0;            // Minimum Rank value
    const double rankMax = 2000;         // Maximum Rank value

    const int nBinsAbsDelta = 100;       // Number of bins for abs_delta
    const double absDeltaMin = 0;        // Minimum abs_delta value
    const double absDeltaMax = 0.3;      // Maximum abs_delta value

    // 2D histogram parameters
    const int nBinsRank2D = 50;
    const int nBinsAbsDelta2D = 50;

    // Canvas parameters
    const int canvasWidth = 1200;
    const int canvasHeight = 800;

    // Style parameters
    const int markerStyle = 20;
    const double markerSize = 0.8;
    const int lineWidth = 2;
    const int fontType = 42;            // Helvetica
    const double titleSize = 0.05;
    const double labelSize = 0.04;

    // =====================================================

    gStyle->SetOptStat(1111);
    gStyle->SetOptFit(1111);
    gStyle->SetPalette(kRainBow);
    gStyle->SetTextFont(fontType);
    gStyle->SetLabelFont(fontType, "XYZ");
    gStyle->SetTitleFont(fontType, "XYZ");

    // Read CSV file
    std::ifstream file(inputCSV);
    if (!file.is_open()) {
        std::cerr << "Error: Cannot open file " << inputCSV << std::endl;
        return;
    }

    std::vector<int> rank;
    std::vector<int> sample_index;
    std::vector<float> y_keras;
    std::vector<float> y_hls;
    std::vector<float> abs_delta;

    std::string line;
    std::getline(file, line); // Skip header

    while (std::getline(file, line)) {
        std::stringstream ss(line);
        std::string item;
        std::vector<std::string> row;

        while (std::getline(ss, item, ',')) {
            row.push_back(item);
        }

        if (row.size() == 5) {
            rank.push_back(std::stoi(row[0]));
            sample_index.push_back(std::stoi(row[1]));
            y_keras.push_back(std::stof(row[2]));
            y_hls.push_back(std::stof(row[3]));
            abs_delta.push_back(std::stof(row[4]));
        }
    }
    file.close();

    std::cout << "Loaded " << rank.size() << " entries from CSV" << std::endl;

    // Create histograms
    TH1F *h_rank = new TH1F("h_rank", "Rank Distribution;Rank;Entries",
                            nBinsRank, rankMin, rankMax);
    TH1F *h_abs_delta = new TH1F("h_abs_delta", "Absolute Delta Distribution;|#Delta|;Entries",
                                 nBinsAbsDelta, absDeltaMin, absDeltaMax);
    TH2F *h_abs_delta_vs_rank = new TH2F("h_abs_delta_vs_rank",
                                         "Absolute Delta vs Rank;Rank;|#Delta|",
                                         nBinsRank2D, rankMin, rankMax,
                                         nBinsAbsDelta2D, absDeltaMin, absDeltaMax);

    TGraph *gr_abs_delta_vs_rank = new TGraph();
    gr_abs_delta_vs_rank->SetName("gr_abs_delta_vs_rank");
    gr_abs_delta_vs_rank->SetTitle("Absolute Delta vs Rank;Rank;|#Delta|");

    // Fill histograms
    for (size_t i = 0; i < rank.size(); i++) {
        h_rank->Fill(rank[i]);
        h_abs_delta->Fill(abs_delta[i]);
        h_abs_delta_vs_rank->Fill(rank[i], abs_delta[i]);
        gr_abs_delta_vs_rank->SetPoint(i, rank[i], abs_delta[i]);
    }

    // Set histogram styles
    h_rank->SetLineColor(kBlue+1);
    h_rank->SetLineWidth(lineWidth);
    h_rank->SetFillColor(kBlue-9);
    h_rank->SetFillStyle(1001);
    h_rank->GetXaxis()->SetTitleSize(titleSize);
    h_rank->GetYaxis()->SetTitleSize(titleSize);
    h_rank->GetXaxis()->SetLabelSize(labelSize);
    h_rank->GetYaxis()->SetLabelSize(labelSize);

    h_abs_delta->SetLineColor(kRed+1);
    h_abs_delta->SetLineWidth(lineWidth);
    h_abs_delta->SetFillColor(kRed-9);
    h_abs_delta->SetFillStyle(1001);
    h_abs_delta->GetXaxis()->SetTitleSize(titleSize);
    h_abs_delta->GetYaxis()->SetTitleSize(titleSize);
    h_abs_delta->GetXaxis()->SetLabelSize(labelSize);
    h_abs_delta->GetYaxis()->SetLabelSize(labelSize);

    h_abs_delta_vs_rank->GetXaxis()->SetTitleSize(titleSize);
    h_abs_delta_vs_rank->GetYaxis()->SetTitleSize(titleSize);
    h_abs_delta_vs_rank->GetXaxis()->SetLabelSize(labelSize);
    h_abs_delta_vs_rank->GetYaxis()->SetLabelSize(labelSize);

    gr_abs_delta_vs_rank->SetMarkerStyle(markerStyle);
    gr_abs_delta_vs_rank->SetMarkerSize(markerSize);
    gr_abs_delta_vs_rank->SetMarkerColor(kBlue);
    gr_abs_delta_vs_rank->GetXaxis()->SetTitleSize(titleSize);
    gr_abs_delta_vs_rank->GetYaxis()->SetTitleSize(titleSize);
    gr_abs_delta_vs_rank->GetXaxis()->SetLabelSize(labelSize);
    gr_abs_delta_vs_rank->GetYaxis()->SetLabelSize(labelSize);

    // Create canvas and draw
    TCanvas *c1 = new TCanvas("c1", "Error Analysis", canvasWidth, canvasHeight);
    c1->Divide(2, 2);

    c1->cd(1);
    gPad->SetGrid();
    h_rank->Draw("HIST");

    c1->cd(2);
    gPad->SetGrid();
    h_abs_delta->Draw("HIST");

    c1->cd(3);
    gPad->SetGrid();
    gPad->SetRightMargin(0.15);
    h_abs_delta_vs_rank->Draw("COLZ");

    c1->cd(4);
    gPad->SetGrid();
    gr_abs_delta_vs_rank->Draw("AP");

    // Save to ROOT file
    TFile *outFile = new TFile(outputROOT, "RECREATE");
    h_rank->Write();
    h_abs_delta->Write();
    h_abs_delta_vs_rank->Write();
    gr_abs_delta_vs_rank->Write();
    outFile->Close();

    std::cout << "ROOT file saved to: " << outputROOT << std::endl;

    // Save to PDF
    c1->SaveAs(outputPDF);
    std::cout << "PDF saved to: " << outputPDF << std::endl;

    // Print statistics
    std::cout << "\n========== Statistics ==========" << std::endl;
    std::cout << "Total entries: " << rank.size() << std::endl;
    std::cout << "Rank range: [" << h_rank->GetXaxis()->GetXmin()
              << ", " << h_rank->GetXaxis()->GetXmax() << "]" << std::endl;
    std::cout << "Rank mean: " << h_rank->GetMean() << std::endl;
    std::cout << "Rank RMS: " << h_rank->GetRMS() << std::endl;
    std::cout << "abs_delta mean: " << h_abs_delta->GetMean() << std::endl;
    std::cout << "abs_delta RMS: " << h_abs_delta->GetRMS() << std::endl;
    std::cout << "================================\n" << std::endl;
}
