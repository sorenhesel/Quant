//
//  scriptingScenarios.h
//  Quant
//
//  Created by Søren  Hesel on 04/09/2026.
//



#pragma once

#include <vector>
using namespace std;

template <class T>
struct SimulData
{
    T numeraire;
    /*vector<T> fwds;
    vector<T> fxs;
    vector<T> discounts;
    vector<T> libors;*/
    T  spot;
    T SVs;
};

template <class T>
using Scenario = vector<SimulData<T>>;


