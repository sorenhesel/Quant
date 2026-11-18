//
//  main.cpp
//  Quant
//
//  Created by Søren  Hesel on 01/09/2026.
//
/*#include "ql/qldefines.hpp"

*/
#include <iostream>
#include <numeric>
#include <thread>


#include <boost/config.hpp>
#include <boost/shared_ptr.hpp>
#include "Scripting/scriptingNodes.hpp"
#include "Scripting/scriptingScenarios.h"
#include "Scripting/scriptingVisitor.h"
#include "Scripting/scriptingIfProc.h"
#include "Scripting/scriptingEvaluator.h"
#include "Scripting/scriptingFuzzyEval.h"
#include "Scripting/quickStack.h"

#include "Scripting/scriptingEvents.h"
#include "Scripting/scriptingSimulDataProc.h"
#include "NumericalRecipies/nr3.h"


	
class SharedBankAccount
 {
 double myBalance;

 public:

double withdraw( const double amount)
 {
if( amount <= myBalance)
 {
 myBalance -= amount;
 return amount;
 }
 else return 0;
 }
};


int main(int argc, const char * argv[]) {
    // insert code here...
    quickStack<std::string> str;
    SimulData<double> simul;
    boost::shared_ptr<SimulData<double>> bSimul;
    Product product;
    auto eval = product.buildEvaluator<double>();
    IfProcessor visitor;
    Evaluator<double> evaluator(4);
    FuzzyEvaluator<double> fuzzyEval(4,5);
    
    
    cout << "Completed " << endl;
    return EXIT_SUCCESS;
}
