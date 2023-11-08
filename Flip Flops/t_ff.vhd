library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity t_ff_en is
    Port ( t   : in STD_LOGIC;
           en  : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           q   : out STD_LOGIC);
end t_ff_en;

-- two segment architecture
architecture two_seg_arch of t_ff_en is

signal q_pres, q_next : std_logic;

begin

    -- next state logic
    q_next <= (t xor q_pres) when en='1' else
    (q_pres and (not en));

    d_ff_process: process( clk, rst ) -- en is not in list
    begin
        if (rst = '1') then
            q_pres <= '0';
        elsif (clk'event and clk='1') then
            q_pres <= q_next;
        end if;
    end process;

    -- output logic
    q <= q_pres;

end two_seg_arch;