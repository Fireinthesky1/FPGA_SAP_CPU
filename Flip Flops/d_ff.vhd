library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_en is
    Port ( d   : in STD_LOGIC;
           en  : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           q   : out STD_LOGIC);
end d_ff_en;

-- two segment architecture
architecture two_seg_arch of d_ff_en is

signal q_pres, q_next : std_logic;

begin

    -- next state logic
    q_next <= d when en='1' else
    q_pres;

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

architecture Behavioral of d_ff_en is

begin

d_ff_process: process( clk, rst ) -- en is not in list

begin
    if (rst = '1') then
    q <= '0';
    elsif rising_edge (clk) then
        if en = '1' then
            q <= d;
        end if;
    end if;
end process;

end Behavioral;