-- VHDL 8 bit processor Project
-- Eight Bit Bitwise Not Test Bench
-- James Hicks Sept 24 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_bit_bitwise_not_tb is
end eight_bit_bitwise_not_tb;

architecture tb_architecture of eight_bit_bitwise_not_tb is

    -- 8 bits in, 8 bits out
    signal test_bits_in : std_logic_vector (7 downto 0);
    signal test_bits_out : std_logic_vector (7 downto 0);

begin
    DUT : entity work.eight_bit_bitwise_not(my_arch)
        port  map (
                    input => test_bits_in (7 downto 0),
                    output => test_bits_out (7 downto 0)
                  );
    process begin
        for I in 0 to 256 loop
            test_bits_in <= std_logic_vector(to_unsigned(I, 8));
            wait for 1 ns;
        end loop;

        assert false report "End of Test";
        wait;

    end process;

end tb_architecture;
