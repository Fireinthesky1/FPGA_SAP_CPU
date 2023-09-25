-- VHDL 8 bit processor Project
-- Eight Bit Bitwise Not
-- James Hicks Sept 24 2023

library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_bitwise_not is
    port (
            input : in std_logic_vector (7 downto 0);
            output : out std_logic_vector (7 downto 0)
         );
end eight_bit_bitwise_not;

architecture my_arch of eight_bit_bitwise_not is

begin

    output(7) <= not input(7);
    output(6) <= not input(6);
    output(5) <= not input(5);
    output(4) <= not input(4);
    output(3) <= not input(3);
    output(2) <= not input(2);
    output(1) <= not input(1);
    output(0) <= not input(0);

end my_arch;