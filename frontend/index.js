const snarkjs = require("snarkjs");
const fs = require("fs");

async function run() {
    const enterNumber = document.getElementById('enterNumber').value;
    const { proof, publicSignals } = await snarkjs.groth16.fullProve(
        {"enterNumber":enterNumber, 
        "lowerLimit":12, 
        "upperLimit":20}, 
        "circuit.wasm", 
        "circuit_final.zkey"
        );

    console.log("Proof: ");
    console.log(JSON.stringify(proof, null, 1));

    const vKey = JSON.parse(fs.readFileSync("verification_key.json"));

    const res = await snarkjs.groth16.verify(vKey, publicSignals, proof);

    if (res === true) {
        console.log("Verification OK");
    } else {
        console.log("Invalid proof");
    }

}

run().then(() => {
    process.exit(0);
});