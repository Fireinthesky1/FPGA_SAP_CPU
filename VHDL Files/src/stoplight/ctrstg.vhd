library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrstg is
  generic(max   : integer  := 9;
          width : integer  := 4 );
  port   (clr   : in  std_logic := '0';
          en    : in  std_logic := '0';
          clk   : in  std_logic := '0';
          tick  : out std_logic := '0';
          cnt   : out std_logic_vector(width-1 downto 0) := (others => '0'));
end ctrstg;

architecture my_arch of ctrstg is

  signal stg_reg, stg_next : unsigned(width-1 downto 0) := (others => '0');

begin

--SEQUENTIAL PORTION
  process(clr, clk)
  begin
    if clr = '1' and rising_edge(clk) then
      stg_reg <= (others => '0');
    elsif rising_edge(clk) then
      stg_reg <= stg_next;
    end if;
  end process;

--COMBINATIONAL PORTION
  stg_next <=(others=>'0')when(((stg_reg=max) and (en='1')) or clr = '1')  else
             stg_reg + 1 when en = '1' else
             stg_reg;

  tick <= '1' when stg_reg = max else '0';

  cnt <= std_logic_vector(stg_reg);

end my_arch;
