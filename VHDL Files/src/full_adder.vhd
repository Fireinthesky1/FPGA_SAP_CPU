-- VHDL 8 bit processor Project
-- Full Adder (not composed of half adders)
-- James Hicks Sept 21 2023

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port(carry_in, i1, i0 : in std_logic;
         carry_out, sum : out std_logic);
end full_adder;

architecture my_arch of full_adder is
    signal p2, p1, p0 : std_logic;
begin
    sum <= carry_in xor i1 xor i0;
    p2 <= carry_in and i1;
    p1 <= carry_in and i0;
    p0 <= i1 and i0;
    carry_out <= p2 or p1 or p0;
end my_arch;