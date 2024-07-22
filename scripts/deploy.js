async function main() {
    // We get the contract to deploy
    const SwiftPay = await ethers.getContractFactory("SwiftPay");
    console.log("Deploying SwiftPay...");
  
    // Deploy the contract
    const swiftPay = await SwiftPay.deploy();
    await swiftPay.deployed();
  
    console.log("SwiftPay deployed to:", swiftPay.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  