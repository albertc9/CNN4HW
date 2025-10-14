#include <TFile.h>
#include <TTree.h>
#include <TH1F.h>
#include <TH2F.h>
#include <TCanvas.h>
#include <TStyle.h>
#include <TLegend.h>
#include <TGraph.h>
#include <TAxis.h>
#include <TProfile.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

void abs_error_vs_y_keras() {
    // ==================== PARAMETERS ====================
    // Input file
    const char* inputCSV = "/home/work1/Work/CNN_iCube_FPGA_b/out/error_analysis/level_a_comparison_20251013_180655.csv";

    // Output files
    const char* outputROOT = "/home/work1/Work/CNN_iCube_FPGA_b/analysis/output/abs_error_vs_y_keras.root";
    const char* outputPDF = "/home/work1/Work/CNN_iCube_FPGA_b/analysis/output/abs_error_vs_y_keras.pdf";

    // Histogram parameters
    const int nBinsYKeras = 100;         // Number of bins for y_keras
    const double yKerasMin = 0.0;        // Minimum y_keras value
    const double yKerasMax = 1.0;        // Maximum y_keras value

    const int nBinsAbsDelta = 100;       // Number of bins for abs_delta
    const double absDeltaMin = 0.0;      // Minimum abs_delta value
    const double absDeltaMax = 0.3;      // Maximum abs_delta value

    // 2D histogram parameters
    const int nBinsYKeras2D = 50;
    const int nBinsAbsDelta2D = 50;

    // Profile histogram parameters
    const int nBinsProfile = 50;

    // Canvas parameters
    const int canvasWidth = 1200;
    const int canvasHeight = 800;

    // Style parameters
    const int markerStyle = 20;
    const double markerSize = 0.5;
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

    std::cout << "Loaded " << y_keras.size() << " entries from CSV" << std::endl;

    // Create histograms
    TH1F *h_y_keras = new TH1F("h_y_keras", "Keras Output Distribution;y_{keras};Entries",
                               nBinsYKeras, yKerasMin, yKerasMax);

    TH1F *h_abs_delta = new TH1F("h_abs_delta", "Absolute Error Distribution;|#Delta|;Entries",
                                 nBinsAbsDelta, absDeltaMin, absDeltaMax);

    TH2F *h_abs_delta_vs_y_keras = new TH2F("h_abs_delta_vs_y_keras",
                                            "Absolute Error vs Keras Output;y_{keras};|#Delta|",
                                            nBinsYKeras2D, yKerasMin, yKerasMax,
                                            nBinsAbsDelta2D, absDeltaMin, absDeltaMax);

    TProfile *prof_abs_delta_vs_y_keras = new TProfile("prof_abs_delta_vs_y_keras",
                                                       "Mean Absolute Error vs Keras Output;y_{keras};<|#Delta|>",
                                                       nBinsProfile, yKerasMin, yKerasMax);

    TGraph *gr_abs_delta_vs_y_keras = new TGraph();
    gr_abs_delta_vs_y_keras->SetName("gr_abs_delta_vs_y_keras");
    gr_abs_delta_vs_y_keras->SetTitle("Absolute Error vs Keras Output;y_{keras};|#Delta|");

    // Fill histograms
    for (size_t i = 0; i < y_keras.size(); i++) {
        h_y_keras->Fill(y_keras[i]);
        h_abs_delta->Fill(abs_delta[i]);
        h_abs_delta_vs_y_keras->Fill(y_keras[i], abs_delta[i]);
        prof_abs_delta_vs_y_keras->Fill(y_keras[i], abs_delta[i]);
        gr_abs_delta_vs_y_keras->SetPoint(i, y_keras[i], abs_delta[i]);
    }

    // Set histogram styles
    h_y_keras->SetLineColor(kBlue+1);
    h_y_keras->SetLineWidth(lineWidth);
    h_y_keras->SetFillColor(kBlue-9);
    h_y_keras->SetFillStyle(1001);
    h_y_keras->GetXaxis()->SetTitleSize(titleSize);
    h_y_keras->GetYaxis()->SetTitleSize(titleSize);
    h_y_keras->GetXaxis()->SetLabelSize(labelSize);
    h_y_keras->GetYaxis()->SetLabelSize(labelSize);

    h_abs_delta->SetLineColor(kRed+1);
    h_abs_delta->SetLineWidth(lineWidth);
    h_abs_delta->SetFillColor(kRed-9);
    h_abs_delta->SetFillStyle(1001);
    h_abs_delta->GetXaxis()->SetTitleSize(titleSize);
    h_abs_delta->GetYaxis()->SetTitleSize(titleSize);
    h_abs_delta->GetXaxis()->SetLabelSize(labelSize);
    h_abs_delta->GetYaxis()->SetLabelSize(labelSize);

    h_abs_delta_vs_y_keras->GetXaxis()->SetTitleSize(titleSize);
    h_abs_delta_vs_y_keras->GetYaxis()->SetTitleSize(titleSize);
    h_abs_delta_vs_y_keras->GetXaxis()->SetLabelSize(labelSize);
    h_abs_delta_vs_y_keras->GetYaxis()->SetLabelSize(labelSize);

    prof_abs_delta_vs_y_keras->SetLineColor(kRed+1);
    prof_abs_delta_vs_y_keras->SetLineWidth(lineWidth);
    prof_abs_delta_vs_y_keras->SetMarkerStyle(markerStyle);
    prof_abs_delta_vs_y_keras->SetMarkerSize(markerSize);
    prof_abs_delta_vs_y_keras->SetMarkerColor(kRed+1);
    prof_abs_delta_vs_y_keras->GetXaxis()->SetTitleSize(titleSize);
    prof_abs_delta_vs_y_keras->GetYaxis()->SetTitleSize(titleSize);
    prof_abs_delta_vs_y_keras->GetXaxis()->SetLabelSize(labelSize);
    prof_abs_delta_vs_y_keras->GetYaxis()->SetLabelSize(labelSize);

    gr_abs_delta_vs_y_keras->SetMarkerStyle(markerStyle);
    gr_abs_delta_vs_y_keras->SetMarkerSize(markerSize);
    gr_abs_delta_vs_y_keras->SetMarkerColor(kBlue);
    gr_abs_delta_vs_y_keras->GetXaxis()->SetTitleSize(titleSize);
    gr_abs_delta_vs_y_keras->GetYaxis()->SetTitleSize(titleSize);
    gr_abs_delta_vs_y_keras->GetXaxis()->SetLabelSize(labelSize);
    gr_abs_delta_vs_y_keras->GetYaxis()->SetLabelSize(labelSize);

    // Create canvas and draw
    TCanvas *c1 = new TCanvas("c1", "Error Analysis vs Keras Output", canvasWidth, canvasHeight);
    c1->Divide(2, 2);

    c1->cd(1);
    gPad->SetGrid();
    h_y_keras->Draw("HIST");

    c1->cd(2);
    gPad->SetGrid();
    h_abs_delta->Draw("HIST");

    c1->cd(3);
    gPad->SetGrid();
    gPad->SetRightMargin(0.15);
    h_abs_delta_vs_y_keras->Draw("COLZ");

    c1->cd(4);
    gPad->SetGrid();
    gr_abs_delta_vs_y_keras->Draw("AP");
    prof_abs_delta_vs_y_keras->Draw("SAME");

    // Create legend for bottom right plot
    c1->cd(4);
    TLegend *leg = new TLegend(0.15, 0.70, 0.45, 0.88);
    leg->SetTextSize(0.035);
    leg->AddEntry(gr_abs_delta_vs_y_keras, "All data points", "p");
    leg->AddEntry(prof_abs_delta_vs_y_keras, "Mean profile", "lp");
    leg->Draw();

    // Save to ROOT file
    TFile *outFile = new TFile(outputROOT, "RECREATE");
    h_y_keras->Write();
    h_abs_delta->Write();
    h_abs_delta_vs_y_keras->Write();
    prof_abs_delta_vs_y_keras->Write();
    gr_abs_delta_vs_y_keras->Write();
    outFile->Close();

    std::cout << "ROOT file saved to: " << outputROOT << std::endl;

    // Save to PDF
    c1->SaveAs(outputPDF);
    std::cout << "PDF saved to: " << outputPDF << std::endl;

    // Print statistics
    std::cout << "\n========== Statistics ==========" << std::endl;
    std::cout << "Total entries: " << y_keras.size() << std::endl;
    std::cout << "y_keras range: [" << h_y_keras->GetXaxis()->GetXmin()
              << ", " << h_y_keras->GetXaxis()->GetXmax() << "]" << std::endl;
    std::cout << "y_keras mean: " << h_y_keras->GetMean() << std::endl;
    std::cout << "y_keras RMS: " << h_y_keras->GetRMS() << std::endl;
    std::cout << "abs_delta mean: " << h_abs_delta->GetMean() << std::endl;
    std::cout << "abs_delta RMS: " << h_abs_delta->GetRMS() << std::endl;
    std::cout << "================================\n" << std::endl;
}
