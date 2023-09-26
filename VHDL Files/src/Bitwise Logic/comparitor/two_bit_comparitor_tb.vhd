-- two bit comparitor test bench --

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity two_bit_comparitor_tb is
end two_bit_comparitor_tb;

architecture tb_arch of two_bit_comparitor_tb is

    signal test_bits_in : std_logic_vector(3 downto 0);
    signal test_bit_out : std_logic;

begin

    DUT : entity work.two_bit_comparitor(struct_arch)
        port map (
                    a => test_bits_in(1 downto 0),
                    b => test_bits_in(3 downto 2),
                    output => test_bit_out
                 );

    process begin
        for I in 0 to 16 loop
            test_bits_in <= std_logic_vector(to_unsigned(I, 4));
            wait for 1 ns;
        end loop;

        assert false report "Test Complete";
        wait;

    end process;

end tb_arch;