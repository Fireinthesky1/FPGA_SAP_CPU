-- VHDL 8 bit processor Project
-- Half Adder Test Bench
-- James Hicks Sept 22 2023

library ieee;
use ieee.std_logic_1164.all;

-- a testbench has no ports
entity half_adder_tb is
end half_adder_tb;

architecture tb_architecture of half_adder_tb is
    component half_adder
        port (
                i1, i0 : in std_logic;
                sum, carry : out std_logic
             );
    end component;

    signal test_bits_in : std_logic_vector (1 downto 0);
    signal test_bits_out : std_logic_vector (1 downto 0);
begin
    DUT : half_adder port map (
                                i1 => test_bits_in(1),
                                i0 => test_bits_in(0),
                                carry => test_bits_out(1),
                                sum => test_bits_out(0)
                              );
    process begin
        -- test vector 1 --
        test_bits_in <= "00";
        wait for 1 ns;

        -- test vector 2 --
        test_bits_in <= "01";
        wait for 1 ns;

        -- test vector 3 --
        test_bits_in <= "10";
        wait for 1 ns;

        -- test vector 4 --
        test_bits_in <= "11";
        wait for 1 ns;

        assert false report "End of Test";
        wait;

    end process;
end tb_architecture;