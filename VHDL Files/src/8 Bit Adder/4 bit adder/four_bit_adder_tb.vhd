-- VHDL 8 bit processor Project
-- Four Bit Adder Test Bench
-- James Hicks Sept 23 2023

-- The structure of test bits in is as follows
-- (carry in bit) & (a input) & (b input)
-- Test bits out simply represents the sum of the two input numbers

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_adder_tb is
end four_bit_adder_tb;

architecture tb_architecture of four_bit_adder_tb is

-- 9 inputs (two 4 bit numbers + carry) 5 outputs (a 4 bit number + carry)
    signal test_bits_in : std_logic_vector (8 downto 0);
    signal test_bits_out : std_logic_vector (4 downto 0);

begin
    DUT : entity work.four_bit_adder(ripple_carry)
        port map (
                    carry_in => test_bits_in (8),

                    a (3) => test_bits_in (7),
                    a (2) => test_bits_in (6),
                    a (1) => test_bits_in (5),
                    a (0) => test_bits_in (4),

                    b (3) => test_bits_in (3),
                    b (2) => test_bits_in (2),
                    b (1) => test_bits_in (1),
                    b (0) => test_bits_in (0),

                    carry_out => test_bits_out (4),

                    sum (3) => test_bits_out (3),
                    sum (2) => test_bits_out (2),
                    sum (1) => test_bits_out (1),
                    sum (0) => test_bits_out (0)
                 );
    process begin
        for I in 0 to 255 loop
            test_bits_in <= std_logic_vector(to_unsigned(I,9));
            wait for 1 ns;
        end loop;

        assert false report "End of Test";
        wait;

    end process;

end tb_architecture;