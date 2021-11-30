const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFT", function () {

    let Nft;
    let nft

    let [_, person1, person2] = [1, 1, 1]


    it("Should deploy NFT contract ", async function () {
        [_, person1, person2] = await ethers.getSigners()

        Nft = await ethers.getContractFactory("Nft");
        nft = await Nft.deploy();
        await nft.deployed();

    });
    it("Should buy  nft ", async function () {
        const _value = await ethers.utils.parseUnits('0.04', 'ether')

        let setNftTx = await nft.Buy({ value: _value });

        // wait until the transaction is mined
        await setNftTx.wait();

        setNftTx = await nft.connect(person1).Buy({ value: _value });

        // wait until the transaction is mined
        await setNftTx.wait();
        // console.log(await greeter.ownerOf(1))
        expect(await nft.ownerOf(1)).to.equal(_.address);
        expect(await nft.ownerOf(2)).to.equal(person1.address);


    });
    it("Should buy two nfts :: must fails ", async function () {
        const _value = await ethers.utils.parseUnits('0.04', 'ether')

        let setNftTx = await nft.Buy({ value: _value });

        // wait until the transaction is mined
        await setNftTx.wait();

        setNftTx = await nft.Buy({ value: _value });

        // wait until the transaction is mined
        await setNftTx.wait();
        // console.log(await greeter.ownerOf(1))
        expect(await nft.ownerOf(1)).to.equal(_.address);

    });
});
