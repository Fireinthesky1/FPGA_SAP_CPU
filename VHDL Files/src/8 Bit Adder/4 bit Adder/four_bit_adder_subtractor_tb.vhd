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
    signal test_bits_in : std_logic_vector (8 downto 0);
    signal test_bits_out : std_logic_vector (4 downto 0);

begin
    DUT : entity work.four_bit_adder_subtractor(my_arch)
        port map (
                    control => test_bits_in (8),
                    a => test_bits_in (7 downto 4),
                    b => test_bits_in (3 downto 0),
                    carry_out => test_bits_out (4),
                    sum_diff => test_bits_out (3 downto 0)
                 );
    process begin
        for I in 0 to 512 loop
            test_bits_in <= std_logic_vector(to_unsigned(I,9));
            wait for 1 ns;
        end loop;

        assert false report "End of Test";
        wait;

    end process;

end tb_architecture;