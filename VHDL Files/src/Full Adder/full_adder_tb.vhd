-- VHDL 8 bit processor Project
-- Full Adder testbench
-- James Hicks Sept 22 2023

library ieee;
use ieee.std_logic_1164.all;

 -- a testbench has no ports
entity full_adder_tb is
end full_adder_tb;

architecture test of full_adder_tb is
    component full_adder
        port (
                carry_in, i1, i0 : in std_logic;
                carry_out, sum : out std_logic
             );
    end component;

    signal test_bits_in : std_logic_vector (2 downto 0);
    signal test_bits_out : std_logic_vector (1 downto 0);
begin
    DUT : full_adder port map (
                                carry_in => test_bits_in(2),
                                i1 => test_bits_in(1),
                                i0 => test_bits_in(0),
                                carry_out => test_bits_out(1),
                                sum => test_bits_out(0)
                              );
    process begin
        -- test vector 1 --
        test_bits_in <= "000";
        wait for 1 ns;

        -- test vector 2 --
        test_bits_in <= "001";
        wait for 1 ns;

        -- test vector 3 --
        test_bits_in <= "010";
        wait for 1 ns;

        -- test vector 4 --
        test_bits_in <= "011";
        wait for 1 ns;

        -- test vector 5 --
        test_bits_in <= "100";
        wait for 1 ns;

        -- test vector 6 --
        test_bits_in <= "101";
        wait for 1 ns;

        -- test vector 7 --
        test_bits_in <= "110";
        wait for 1 ns;

        -- test vector 8 --
        test_bits_in <= "111";
        wait for 1 ns;

        assert false report "End of Test";
        wait;

    end process;
end test;