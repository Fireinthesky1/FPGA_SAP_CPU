-- VHDL 8 bit processor Project
-- Eight Bit Bitwise AND Test Bench
-- James Hicks Sept 25 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_bit_bitwise_and_tb is
end eight_bit_bitwise_and_tb;

architecture tb_architecture of eight_bit_bitwise_and_tb is

    -- 16 bits in, 8 bits out
    signal test_bits_in_a : std_logic_vector (7 downto 0);
    signal test_bits_in_b : std_logic_vector (7 downto 0);
    signal test_bits_out  : std_logic_vector (7 downto 0);

begin
    DUT : entity work.eight_bit_bitwise_and(my_arch)
        port map (
                    a => test_bits_in_a (7 downto 0),
                    b => test_bits_in_b (7 downto 0),
                    output => test_bits_out (7 downto 0)
                 );
    process begin
        for I in 0 to 255 loop
            test_bits_in_a <= std_logic_vector(to_unsigned(I, 8));
            test_bits_in_b <= std_logic_vector(to_unsigned(I, 8));
            wait for 1 ns;
        end loop;

        assert false report "End of Test";
        wait;

    end process;

end tb_architecture;