//
//  scriptingSimulDataProc.h
//  Quant
//
//  Created by Søren  Hesel on 10/09/2026.
//

#pragma once

#include "scriptingEvents.h"
struct SimulRequest
{
    /*vector<pair<Code, Date>> fwdMats;
    vector<triplet<Ccy,Ccy, Date>> fxMats;
    vector<triplet<Ccy, Date, Date>> discMats;
    vector<triplet<Idx, Date, Date>> liborMats;
     */
    //vector<Date> discMats;
    bool showSVs;
    SimulRequest():showSVs(false){}
};

template <class T>
class SimDataProc : public constVisitor
{
protected:
    SimulRequest mySimulRequests;
    
public:
    SimDataProc(const size_t nVar) {
        mySimulRequests = {.discMats = vector<Date>(nVar)};
    }
    
    virtual ~SimDataProc(){}
    SimDataProc& operator=( const SimDataProc& rhs)
    {
        if( this == &rhs) return *this;
        mySimulRequests = rhs.mySimulRequests;
        return *this;
    }

    //Accessors:
    const SimulRequest& simulRequest() const{
        return mySimulRequests;
    }
    
    /*void visitArguments(const Node& node) override
    {
        node.arguments
        mySimulRequests.discMats[]
    }*/

};
