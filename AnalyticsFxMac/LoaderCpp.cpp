//
//  LoaderCpp.cpp
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/30.
//  Copyright © 2017年 osanai. All rights reserved.
//

#include "LoaderCpp.hpp"


using namespace std;


void printHistoryHeader(const HistoryHeader& header)
{
    cout << "version   : " << header.version << endl;
    cout << "copyright : " << header.copyright << endl;
    cout << "symbol    : " << header.symbol << endl;
    cout << "period    : " << header.period << endl;
    cout << "digits    : " << header.period << endl;
    time_t tmp = header.timesign;
    cout << "timesign  : " << put_time(localtime(&tmp), "%F %T") << endl;
    tmp = header.last_sync;
    cout << "last_sync : " << put_time(localtime(&tmp), "%F %T") << endl;
}

void printRate(const RateInfo& rate, ostream& ost)
{
    time_t tmp = rate.ctm;
    ost << put_time(std::localtime(&tmp), "%F %T");
    ost << "," << rate.open;
    ost << "," << rate.low;
    ost << "," << rate.high;
    ost << "," << rate.close;
    ost << "," << rate.vol << endl;
}

//RateInfo *doLoadA(const char* filepath, const char* outpath) {
RateInfo *doLoadB(const char* filepath) {

    ifstream ifs;
    ifs.open(filepath, ios::in | ios::binary);
    if(!ifs) {
        cout << "file open error" << endl;
//        return 1;
    }
    
    HistoryHeader header;
    ifs.read((char*)&header, sizeof(header));
    if(ifs.bad()) {
        cout << "file read error" << endl;
//        return 1;
    }
    
    printHistoryHeader(header);
    
//    ofstream ofs;
//    ofs.open(outpath, ios::out | ios::trunc);
//    if(!ofs.is_open()) {
//        cout << "failed to create a file : " << outpath << endl;
//        return 1;
//    }
    
    
    RateInfo *rates = (RateInfo*)malloc(1000 * sizeof(RateInfo));
    
    int count = 0;
    RateInfo rate;
    while(!ifs.eof()
          && count<1000) {
        
        ifs.read((char*)&rate, 44);
        if(ifs.bad()) {
            cout << "file read error" << endl;
//            return 1;
        }
//        printRate(rate, ofs);
        
        rates[count] = rate;
        
        count++;
//        if (count%100000==0) {
//            cout << count << " ";
//        }
    }

    cout << "done" << endl;
    
    return rates;

}
