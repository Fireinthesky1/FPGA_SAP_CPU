library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity disp_mux is
    Generic ( N  : integer := 20);  -- refresh rate around 800 Hz
    Port ( in0   :  in STD_LOGIC_VECTOR (7 downto 0);
           in1   :  in STD_LOGIC_VECTOR (7 downto 0);
           in2   :  in STD_LOGIC_VECTOR (7 downto 0);
           in3   :  in STD_LOGIC_VECTOR (7 downto 0);
           in4   :  in STD_LOGIC_VECTOR (7 downto 0);
           in5   :  in STD_LOGIC_VECTOR (7 downto 0);
           in6   :  in STD_LOGIC_VECTOR (7 downto 0);
           in7   :  in STD_LOGIC_VECTOR (7 downto 0);
           rst   :  in STD_LOGIC;
           clk   :  in STD_LOGIC;
           sseg  : out STD_LOGIC_VECTOR (7 downto 0);
           anode : out STD_LOGIC_VECTOR (7 downto 0));
end disp_mux;

architecture Behavioral of disp_mux is

    -- refresh rate around 800 MHz
    --constant N : integer := 20;
    signal q_reg, q_next : unsigned(N-1 downto 0);
    signal sel : std_logic_vector (2 downto 0);

begin

    -- register
    process(clk, rst)
    begin
        if rst = '1' then
            q_reg <= (others => '0');
        elsif (clk'event and clk = '1') then
            q_reg <= q_next;
        end if;
    end process;
    
    -- next state logic for the counter
    q_next <= q_reg + 1;
    
    -- 3 MSBs of counter to control 8-to-1 MUX
    -- and to generate active-low anode enable signal
    sel <= std_logic_vector(q_reg(N-1 downto N-3));

    process (sel, in0, in1, in2, in3, in4, in5, in6, in7)
    begin
        case sel is
            when "000" =>   anode <= "11111110";  sseg  <= in0;
            when "001" =>   anode <= "11111101";  sseg  <= in1;
            when "010" =>   anode <= "11111011";  sseg  <= in2;
            when "011" =>   anode <= "11110111";  sseg  <= in3;
            when "100" =>   anode <= "11101111";  sseg  <= in4;
            when "101" =>   anode <= "11011111";  sseg  <= in5;
            when "110" =>   anode <= "10111111";  sseg  <= in6;
            when others =>  anode <= "01111111";  sseg  <= in7;
        end case;
    end process;


end Behavioral;
