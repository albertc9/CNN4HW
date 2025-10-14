#include <TFile.h>
#include <TTree.h>
#include <TH1F.h>
#include <TH2F.h>
#include <TCanvas.h>
#include <TStyle.h>
#include <TLegend.h>
#include <TGraph.h>
#include <TAxis.h>
#include <TLine.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

void keras_dis_vs_hls_dis() {
    // ==================== PARAMETERS ====================
    // Input file
    const char* inputCSV = "/home/work1/Work/CNN_iCube_FPGA_b/out/error_analysis/level_a_comparison_20251013_180655.csv";

    // Output files
    const char* outputROOT = "/home/work1/Work/CNN_iCube_FPGA_b/analysis/output/keras_dis_vs_hls_dis.root";
    const char* outputPDF = "/home/work1/Work/CNN_iCube_FPGA_b/analysis/output/keras_dis_vs_hls_dis.pdf";

    // Histogram parameters
    const int nBinsOutput = 100;         // Number of bins for output distributions
    const double outputMin = 0.0;        // Minimum output value
    const double outputMax = 1.0;        // Maximum output value

    // 2D comparison histogram parameters
    const int nBins2D = 50;

    // Canvas parameters
    const int canvasWidth = 1600;
    const int canvasHeight = 900;

    // Style parameters
    const int markerStyleKeras = 20;
    const int markerStyleHLS = 21;
    const double markerSize = 0.4;
    const int lineWidthKeras = 2;
    const int lineWidthHLS = 2;
    const int colorKeras = kBlue+1;
    const int colorHLS = kRed+1;
    const int fontType = 42;            // Helvetica
    const double titleSize = 0.05;
    const double labelSize = 0.04;

    // Legend parameters
    const double legendX1 = 0.65;
    const double legendY1 = 0.70;
    const double legendX2 = 0.88;
    const double legendY2 = 0.88;

    // =====================================================

    gStyle->SetOptStat(1111);
    gStyle->SetOptFit(0);
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
    TH1F *h_keras = new TH1F("h_keras", "Keras Output Distribution;Output Value;Entries",
                             nBinsOutput, outputMin, outputMax);

    TH1F *h_hls = new TH1F("h_hls", "HLS Output Distribution;Output Value;Entries",
                           nBinsOutput, outputMin, outputMax);

    TH1F *h_overlay = new TH1F("h_overlay", "Keras vs HLS Output Comparison;Output Value;Entries",
                               nBinsOutput, outputMin, outputMax);

    TH2F *h_keras_vs_hls = new TH2F("h_keras_vs_hls",
                                    "HLS Output vs Keras Output;y_{keras};y_{HLS}",
                                    nBins2D, outputMin, outputMax,
                                    nBins2D, outputMin, outputMax);

    TGraph *gr_keras_vs_hls = new TGraph();
    gr_keras_vs_hls->SetName("gr_keras_vs_hls");
    gr_keras_vs_hls->SetTitle("HLS Output vs Keras Output;y_{keras};y_{HLS}");

    // Difference histogram (HLS - Keras)
    TH1F *h_difference = new TH1F("h_difference", "Output Difference (HLS - Keras);y_{HLS} - y_{keras};Entries",
                                  100, -0.5, 0.5);

    // Fill histograms
    for (size_t i = 0; i < y_keras.size(); i++) {
        h_keras->Fill(y_keras[i]);
        h_hls->Fill(y_hls[i]);
        h_keras_vs_hls->Fill(y_keras[i], y_hls[i]);
        gr_keras_vs_hls->SetPoint(i, y_keras[i], y_hls[i]);
        h_difference->Fill(y_hls[i] - y_keras[i]);
    }

    // Set histogram styles for Keras
    h_keras->SetLineColor(colorKeras);
    h_keras->SetLineWidth(lineWidthKeras);
    h_keras->SetFillColor(colorKeras);
    h_keras->SetFillStyle(3004);  // hatched style
    h_keras->GetXaxis()->SetTitleSize(titleSize);
    h_keras->GetYaxis()->SetTitleSize(titleSize);
    h_keras->GetXaxis()->SetLabelSize(labelSize);
    h_keras->GetYaxis()->SetLabelSize(labelSize);

    // Set histogram styles for HLS
    h_hls->SetLineColor(colorHLS);
    h_hls->SetLineWidth(lineWidthHLS);
    h_hls->SetFillColor(colorHLS);
    h_hls->SetFillStyle(3005);  // hatched style
    h_hls->GetXaxis()->SetTitleSize(titleSize);
    h_hls->GetYaxis()->SetTitleSize(titleSize);
    h_hls->GetXaxis()->SetLabelSize(labelSize);
    h_hls->GetYaxis()->SetLabelSize(labelSize);

    // Set histogram styles for overlay
    h_overlay->GetXaxis()->SetTitleSize(titleSize);
    h_overlay->GetYaxis()->SetTitleSize(titleSize);
    h_overlay->GetXaxis()->SetLabelSize(labelSize);
    h_overlay->GetYaxis()->SetLabelSize(labelSize);

    // Set histogram styles for difference
    h_difference->SetLineColor(kGreen+2);
    h_difference->SetLineWidth(lineWidthKeras);
    h_difference->SetFillColor(kGreen-9);
    h_difference->SetFillStyle(1001);
    h_difference->GetXaxis()->SetTitleSize(titleSize);
    h_difference->GetYaxis()->SetTitleSize(titleSize);
    h_difference->GetXaxis()->SetLabelSize(labelSize);
    h_difference->GetYaxis()->SetLabelSize(labelSize);

    // Set 2D histogram styles
    h_keras_vs_hls->GetXaxis()->SetTitleSize(titleSize);
    h_keras_vs_hls->GetYaxis()->SetTitleSize(titleSize);
    h_keras_vs_hls->GetXaxis()->SetLabelSize(labelSize);
    h_keras_vs_hls->GetYaxis()->SetLabelSize(labelSize);

    // Set graph styles
    gr_keras_vs_hls->SetMarkerStyle(markerStyleKeras);
    gr_keras_vs_hls->SetMarkerSize(markerSize);
    gr_keras_vs_hls->SetMarkerColor(kBlue);
    gr_keras_vs_hls->GetXaxis()->SetTitleSize(titleSize);
    gr_keras_vs_hls->GetYaxis()->SetTitleSize(titleSize);
    gr_keras_vs_hls->GetXaxis()->SetLabelSize(labelSize);
    gr_keras_vs_hls->GetYaxis()->SetLabelSize(labelSize);

    // Create canvas and draw
    TCanvas *c1 = new TCanvas("c1", "Keras vs HLS Distribution Comparison", canvasWidth, canvasHeight);
    c1->Divide(3, 2);

    // Plot 1: Keras distribution
    c1->cd(1);
    gPad->SetGrid();
    h_keras->Draw("HIST");

    // Plot 2: HLS distribution
    c1->cd(2);
    gPad->SetGrid();
    h_hls->Draw("HIST");

    // Plot 3: Overlay comparison
    c1->cd(3);
    gPad->SetGrid();
    // Determine max for proper scaling
    double maxKeras = h_keras->GetMaximum();
    double maxHLS = h_hls->GetMaximum();
    double maxVal = (maxKeras > maxHLS) ? maxKeras : maxHLS;
    h_keras->SetMaximum(maxVal * 1.1);
    h_keras->Draw("HIST");
    h_hls->Draw("HIST SAME");

    TLegend *leg1 = new TLegend(legendX1, legendY1, legendX2, legendY2);
    leg1->SetTextSize(0.04);
    leg1->AddEntry(h_keras, "Keras Output", "f");
    leg1->AddEntry(h_hls, "HLS Output", "f");
    leg1->Draw();

    // Plot 4: Difference histogram
    c1->cd(4);
    gPad->SetGrid();
    h_difference->Draw("HIST");

    // Plot 5: 2D heatmap
    c1->cd(5);
    gPad->SetGrid();
    gPad->SetRightMargin(0.15);
    h_keras_vs_hls->Draw("COLZ");

    // Draw diagonal line (y=x) for reference
    TLine *diagLine = new TLine(outputMin, outputMin, outputMax, outputMax);
    diagLine->SetLineColor(kBlack);
    diagLine->SetLineWidth(2);
    diagLine->SetLineStyle(2);  // dashed
    diagLine->Draw("SAME");

    // Plot 6: Scatter plot with diagonal
    c1->cd(6);
    gPad->SetGrid();
    gr_keras_vs_hls->Draw("AP");
    gr_keras_vs_hls->GetXaxis()->SetLimits(outputMin, outputMax);
    gr_keras_vs_hls->GetYaxis()->SetRangeUser(outputMin, outputMax);

    TLine *diagLine2 = new TLine(outputMin, outputMin, outputMax, outputMax);
    diagLine2->SetLineColor(kRed);
    diagLine2->SetLineWidth(2);
    diagLine2->SetLineStyle(2);  // dashed
    diagLine2->Draw("SAME");

    TLegend *leg2 = new TLegend(0.15, 0.70, 0.45, 0.88);
    leg2->SetTextSize(0.035);
    leg2->AddEntry(gr_keras_vs_hls, "Data points", "p");
    leg2->AddEntry(diagLine2, "y = x (perfect match)", "l");
    leg2->Draw();

    // Save to ROOT file
    TFile *outFile = new TFile(outputROOT, "RECREATE");
    h_keras->Write();
    h_hls->Write();
    h_difference->Write();
    h_keras_vs_hls->Write();
    gr_keras_vs_hls->Write();
    outFile->Close();

    std::cout << "ROOT file saved to: " << outputROOT << std::endl;

    // Save to PDF
    c1->SaveAs(outputPDF);
    std::cout << "PDF saved to: " << outputPDF << std::endl;

    // Print statistics
    std::cout << "\n========== Statistics ==========" << std::endl;
    std::cout << "Total entries: " << y_keras.size() << std::endl;
    std::cout << "\nKeras Output:" << std::endl;
    std::cout << "  Mean: " << h_keras->GetMean() << std::endl;
    std::cout << "  RMS:  " << h_keras->GetRMS() << std::endl;
    std::cout << "\nHLS Output:" << std::endl;
    std::cout << "  Mean: " << h_hls->GetMean() << std::endl;
    std::cout << "  RMS:  " << h_hls->GetRMS() << std::endl;
    std::cout << "\nDifference (HLS - Keras):" << std::endl;
    std::cout << "  Mean: " << h_difference->GetMean() << std::endl;
    std::cout << "  RMS:  " << h_difference->GetRMS() << std::endl;
    std::cout << "================================\n" << std::endl;
}
