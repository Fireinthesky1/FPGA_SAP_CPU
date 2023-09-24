-- VHDL 8 bit processor Project
-- Eight Bit Adder Test Bench
-- James Hicks Sept 23 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_bit_adder_tb is
end eight_bit_adder_tb;

architecture tb_architecture of eight_bit_adder_tb is

-- 17 inputs (two 8 bit #'s + carry) 9 outputs (a 8 bit # + carry)
    signal test_bits_in : std_logic_vector (16 downto 0);
    signal test_bits_out : std_logic_vector (8 downto 0);

begin
    DUT : entity work.eight_bit_adder(ripple_carry)
        port map (
                    carry_in => test_bits_in (16),

                    a (7) => test_bits_in (15),
                    a (6) => test_bits_in (14),
                    a (5) => test_bits_in (13),
                    a (4) => test_bits_in (12),
                    a (3) => test_bits_in (11),
                    a (2) => test_bits_in (10),
                    a (1) => test_bits_in (9),
                    a (0) => test_bits_in (8),

                    b (7) => test_bits_in (7),
                    b (6) => test_bits_in (6),
                    b (5) => test_bits_in (5),
                    b (4) => test_bits_in (4),
                    b (3) => test_bits_in (3),
                    b (2) => test_bits_in (2),
                    b (1) => test_bits_in (1),
                    b (0) => test_bits_in (0),

                    carry_out => test_bits_out (8),

                    sum (7) => test_bits_out (7),
                    sum (6) => test_bits_out (6),
                    sum (5) => test_bits_out (5),
                    sum (4) => test_bits_out (4),
                    sum (3) => test_bits_out (3),
                    sum (2) => test_bits_out (2),
                    sum (1) => test_bits_out (1),
                    sum (0) => test_bits_out (0)
                 );
    process begin
        for I in 0 to 512 loop
            test_bits_in <= std_logic_vector(to_unsigned(I,17));
            wait for 1 ns;
        end loop;

        assert false report "End of Test";
        wait;

    end process;

end tb_architecture;