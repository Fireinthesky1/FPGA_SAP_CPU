-- VHDL 8 bit processor Project
-- eight Bit Zero
-- James Hicks Sept 24 2023

library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_zero is
    port (
            input : in std_logic_vector (7 downto 0);
            output : out std_logic_vector (7 downto 0)
         );
end eight_bit_zero;

architecture my_arch of eight_bit_zero is
begin
    output <= "00000000";
end my_arch;