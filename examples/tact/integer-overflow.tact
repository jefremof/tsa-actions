contract Overflow {

    get fun overflow(y: Int): Int {
        let x = 1 << 255;
        if (y < 1 << 255) {
            throw(12345);
        }
        return x + y;
    }
}