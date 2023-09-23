-- VHDL 8 bit processor Project
-- Two Bit Adder Test Bench
-- James Hicks Sept 22 2023

library ieee;
use ieee.std_logic_1164.all;

-- a testbench has no ports
entity two_bit_adder_tb is
end two_bit_adder_tb;

architecture tb_architecture of two_bit_adder_tb is

-- five inputs three outputs
    signal test_bits_in : std_logic_vector (4 downto 0);
    signal test_bits_out : std_logic_vector (2 downto 0);

begin
    DUT : entity work.two_bit_adder(ripple_carry)
        port map (
                    carry_in => test_bits_in (4),
                    a (1) => test_bits_in (3),
                    a (0) => test_bits_in (2),
                    b (1) => test_bits_in (1),
                    b (0) => test_bits_in (0),
                    carry_out => test_bits_out(2),
                    sum (1) => test_bits_out(1),
                    sum (0) => test_bits_out(0)
                );
    process begin
        -- test vector 1 --
        test_bits_in <= "00000";
        wait for 1 ns;

        -- test vector 2 --
        test_bits_in <= "00001";
        wait for 1 ns;

        -- test vector 3 --
        test_bits_in <= "00010";
        wait for 1 ns;

        -- test vector 4 --
        test_bits_in <= "00011";
        wait for 1 ns;

        -- test vector 5 --
        test_bits_in <= "00100";
        wait for 1 ns;

        -- test vector 6 --
        test_bits_in <= "00101";
        wait for 1 ns;

        -- test vector 7 --
        test_bits_in <= "00110";
        wait for 1 ns;

        -- test vector 8 --
        test_bits_in <= "00111";
        wait for 1 ns;

        -- test vector 9 --
        test_bits_in <= "01000";
        wait for 1 ns;

        -- test vector 10 --
        test_bits_in <= "01001";
        wait for 1 ns;

        -- test vector 11 --
        test_bits_in <= "01010";
        wait for 1 ns;

        -- test vector 12 --
        test_bits_in <= "01011";
        wait for 1 ns;

        -- test vector 13 --
        test_bits_in <= "01100";
        wait for 1 ns;

        -- test vector 14 --
        test_bits_in <= "01101";
        wait for 1 ns;

        -- test vector 15 --
        test_bits_in <= "01110";
        wait for 1 ns;

        -- test vector 16 --
        test_bits_in <= "01111";
        wait for 1 ns;

        assert false report "End of Test";
        wait;

    end process;

end tb_architecture;