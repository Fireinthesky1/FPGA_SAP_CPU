-- VHDL 8 bit processor Project
-- Four Bit Binary Adder Subtractor Test Bench
-- James Hicks Sept 29 2023

-- The bit structure is as follows
-- (control bit) & (a input) & (b input)
-- Test bits out simply represents the sum or difference of inputs

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_adder_subtractor_tb is
end four_bit_adder_subtractor_tb;

architecture tb_architecture of four_bit_adder_subtractor_tb is

-- 9 inputs (2 4-bit numbers + control) 5 outputs (a 4 bit number + carry)
    signal control      : std_logic;
    signal a,b          : std_logic_vector (3 downto 0);
    signal carry_out    : std_logic;
    signal sum_diff     : std_logic_vector (3 downto 0);

begin
    DUT : entity work.four_bit_adder_subtractor(my_arch)
        port map (
                    control => control,
                    a => a,
                    b => b,
                    carry_out => carry_out,
                    sum_diff => sum_diff
                 );
    process begin
        -- test 4 + 4 = 8 (out of range for signed 4 bit number)
        control <= '0';
        a <= "0100";
        b <= "0100";
        wait for 1 ns;

        -- test for -4 + -5 = -9 (out of range for signed 4 bit number)
        control <= '0';
        a <= "1100";
        b <= "1011";
        wait for 1 ns;

        -- test adding positive and negative extremes 7 + -8 = -1
        control <= '0';
        a <= "0111";
        b <= "1000";
        wait for 1 ns;

        -- test for subtraction overflow 3 - -6 = 9 (out of range)
        control <= '1';
        a <= "0101";
        b <= "1010";
        wait for 1 ns;

        -- test for subtraction underflow -7 - 7 (out of range)
        control <= '1';
        a <= "1111";
        b <= "0111";
        wait for 1 ns;

        -- test for 0 - 1 = -1
        control <= '1';
        a <= "0000";
        b <= "0001";
        wait for 1 ns;

        -- test for 1 - -1 = 0
        control <= '1';
        a <= "1111";
        b <= "1111";
        wait for 1 ns;

        assert false report "End of Test";
        wait;

    end process;

end tb_architecture;