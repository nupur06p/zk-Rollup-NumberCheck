
pragma circom 2.1.9;

include "../node_modules/circomlib/circuits/comparators.circom";

template NumberCheck(){
    
    signal input enterNumber;
    signal input lowerLimit; //public, set by verifier
    signal input upperLimit; //public, set by verifier.

    signal outputGreaterThan;
    signal outputLessThan;

    signal output isOutputWithinLimit;
    
    component greaterThan = GreaterThan(7);

    greaterThan.in[0] <== enterNumber;
    greaterThan.in[1] <== lowerLimit;
    outputGreaterThan <== greaterThan.out;

    component lessThan = LessThan(7);

    lessThan.in[0] <== enterNumber;
    lessThan.in[1] <== upperLimit;
    outputLessThan <== lessThan.out;

    isOutputWithinLimit <== outputLessThan * outputGreaterThan;

    //isOutputWithinLimit === outputLessThan * outputGreaterThan; 
    //If assignment (===) is used instead of (<==), in the above expression, then we cannot 
    //generate invalid proofs. We want the verifier to be able to generate inavlid proofs as well.
}

component main{public [lowerLimit,upperLimit]} = NumberCheck();