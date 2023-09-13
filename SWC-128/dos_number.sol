pragma solidity ^0.4.25;

contract DosNumber {

    uint numElements = 0;
    uint[] array;

    function insertNnumbers(uint value,uint numbers) public {

        // 如果数字大于382，那么Gas的DOS会有所增加或减少，具体取决于实际的Gas限制。
        for(uint i=0;i<numbers;i++) {
            if(numElements == array.length) {
                array.length += 1;
            }
            array[numElements++] = value;
        }
    }

    function clear() public {
        require(numElements>1500);
        numElements = 0;
    }

    // GasDOS清除
    function clearDOS() public {

        // 数字取决于实际的Gas限制。
        require(numElements>1500);
        array = new uint[](0);
        numElements = 0;
    }

    function getLengthArray() public view returns(uint) {
        return numElements;
    }

    function getRealLengthArray() public view returns(uint) {
        return array.length;
    }
}