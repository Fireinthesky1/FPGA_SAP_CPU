-- VHDL 8 bit processor project
-- Three Bit ALU
-- James Hicks Oct 8 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity three_bit_ALU is
    port (
            num1, num2      : in std_logic_vector (2 downto 0);
            s_u             : in std_logic;
            add             : in std_logic;
            subtract        : in std_logic;
            multiply        : in std_logic;
            result          : out std_logic_vector (5 downto 0)
         );
end three_bit_ALU;

architecture my_arch of three_bit_ALU is

    signal control : std_logic_vector (3 downto 0);

begin
    control <= s_u & add & subtract & multiply;
    with control select result <=
        std_logic_vector(unsigned(num1) + unsigned(num2)) when "0100",
        std_logic_vector(unsigned(num1) + unsigned(num2)) when "0101",
        std_logic_vector(unsigned(num1) + unsigned(num2)) when "0110",
        std_logic_vector(unsigned(num1) + unsigned(num2)) when "0111",
        std_logic_vector(unsigned(num1) - unsigned(num2)) when "0010",
        std_logic_vector(unsigned(num1) - unsigned(num2)) when "0011",
        std_logic_vector(unsigned(num1) * unsigned(num2)) when "0001",
        std_logic_vector(signed(num1) + signed(num2)) when "1100",
        std_logic_vector(signed(num1) + signed(num2)) when "1101",
        std_logic_vector(signed(num1) + signed(num2)) when "1110",
        std_logic_vector(signed(num1) + signed(num2)) when "1111",
        std_logic_vector(signed(num1) - signed(num2)) when "1010",
        std_logic_vector(signed(num1) - signed(num2)) when "1011",
        std_logic_vector(signed(num1) * signed(num2)) when "1001",
        "000000" when others;
end my_arch;