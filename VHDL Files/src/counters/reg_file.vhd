library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity reg_file is
Generic (
B : integer := 6 ; -- number of bits
W : integer := 4 -- number of address bits (2^W addresses total)
);
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
wr_en : in STD_LOGIC;
w_addr : in STD_LOGIC_VECTOR (W-1 downto 0);
r_addr : in STD_LOGIC_VECTOR (W-1 downto 0);
w_data : in STD_LOGIC_VECTOR (B-1 downto 0);
r_data : out STD_LOGIC_VECTOR (B-1 downto 0)
);
end reg_file;
architecture Behavioral of reg_file is
-- define new type:
-- an array of 2^W rows with each row
-- being a B-bit std_logic_vector
type reg_file_type is array (0 to 2**W-1) of -- using "to"
std_logic_vector (B-1 downto 0);
-- Define a new signal of the type we just created
signal array_reg : reg_file_type;
-- create integers for the arguments of array_reg
signal w_addr_i, r_addr_i : integer range 0 to W**2-1;
begin
-- get addresses as "integers"
w_addr_i <= to_integer(unsigned(w_addr));
r_addr_i <= to_integer(unsigned(r_addr));
-- array creation
process (clk, rst)
begin
if (rst = '1') then
array_reg <= (others => (others => '0') ); -- zero the whole
array
elsif ( clk'event and clk='1' ) then
if (wr_en = '1') then
array_reg(w_addr_i) <= w_data; -- writes data onto
the array
end if;
end if;
end process;
-- read port (retrieve data from the array)
-- this will get done regardless or whether we are writing or not
r_data <= array_reg(r_addr_i);
end Behavioral;
