-- VHDL 8 bit processor Project
-- Four Bit Binary Adder Subtractor
-- James Hicks Sept 29 2023

library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder_subtractor is
    port (
            control            : in std_logic;
            a, b               : in std_logic_vector (3 downto 0);
            carry_out          : out std_logic;
            sum_diff           : out std_logic_vector (3 downto 0)
         );
end four_bit_adder_subtractor;

-- The control is essentially a carry in
-- With the added caviet that in addition to being added
-- to the other inputs, it also decides which output to take

architecture my_arch of four_bit_adder_subtractor is

    signal add_carry, sub_carry : std_logic;
    signal sum, diff : std_logic_vector (3 downto 0);
    signal b_flipped : std_logic_vector (3 downto 0);

begin

    b_flipped <= (not b(3)) & (not b(2)) & (not b(1)) & (not b(0));

    add : entity work.four_bit_adder(ripple_carry)
        port map (
                    carry_in => control,
                    a => a,
                    b => b,
                    carry_out => add_carry,
                    sum => sum
                 );
    subtract : entity work.four_bit_adder(ripple_carry)
        port map (
                    carry_in => control,
                    a => a,
                    b => b_flipped,
                    carry_out => sub_carry,
                    sum => diff
                 );

with control select sum_diff <=
    sum when '0',
    diff when '1',
    "XXXX" when others;

with control select carry_out <=
    add_carry when '0',
    sub_carry when '1',
    'X' when others;

--with control select sum_diff <=
--    sum when '0',
--    diff when '1',
--    "XXXX" when others;
--
--with control select carry_out <=
--    add_carry when '0',
--    '0' when '1',
--    'X' when others;

end my_arch;