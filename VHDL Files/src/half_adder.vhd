-- VHDL 8 bit processor Project
-- Half Adder
-- James Hicks Sept 21 2023

library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
port (i1, i0 : in std_logic;
      sum, carry : out std_logic);
end half_adder;

architecture my_arch of half_adder is
begin
    sum <= i1 xor i0;
    carry <= i1 and i0;
end my_arch;