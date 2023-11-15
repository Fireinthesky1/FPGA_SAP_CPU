-- this code was written by Dr. Esteban Rodriguez-Marek

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debouncer is
    Generic (MAX_CNT : integer := 1000000; --TODO::1000000
             N       : integer := 20);     -- ceil(log2 1000000) = 20             
    Port ( reset : in STD_LOGIC;
           clk   : in STD_LOGIC;
           sw    : in STD_LOGIC;
           db    : out STD_LOGIC);
end debouncer;

architecture scheme1_arch of debouncer is

    -- signals for counter

    signal ctr_reg, ctr_nxt : unsigned (N-1 downto 0);
    signal m_tick : std_logic; -- 10 ms tick
    
    -- define a new enumerated state type 
    type state_type is (zero, wait1_1, wait1_2, wait1_3,
                        one,  wait0_1, wait0_2, wait0_3);
    -- need to define present state and next state signals
    signal state_reg : state_type;
    signal state_nxt : state_type;

begin

    --////////////////////////
    -- counter for 10- ms tick
    --////////////////////////

    -- counter register
    counter_process: process (reset,clk) -- no need for reset, since it is free-running
    begin
        if (reset='1') then
            ctr_reg <= (others => '0');
        elsif ( clk'event and clk='1' ) then
            ctr_reg <= ctr_nxt;
        end if;
    end process;

    -- next state logic
    ctr_nxt <= (others => '0') when (ctr_reg=MAX_CNT-1) else
               ctr_reg + 1;

    -- output tick (one-clock wide, once every 10 ms)
    m_tick <= '1' when (ctr_reg=MAX_CNT-1) else
              '0'; 

    --////////////////////////
    -- Debouncing FSM
    --////////////////////////

    -- state register
    process (clk, reset)
    begin
        if ( reset = '1' ) then
            state_reg <= zero; -- always starts at state zero
        elsif ( clk'event and clk='1' ) then
            state_reg <= state_nxt; 
        end if;
    end process;

    -- next state and output logic (Moore ckt)
    process ( state_reg, sw, m_tick )
    begin
        -- defaults for next state and output
        state_nxt <= state_reg; -- default is to stay in same state
        db <= '0';              -- default is to output zero

        -- go through each one of the 8 states
        case state_reg is
            -- sw is zero and we are debouncing a rising edge
            when zero =>
                if ( sw='1' ) then  -- advance when sw=1
                    state_nxt <= wait1_1;
                end if;
            when wait1_1 =>
                if ( sw='0' ) then -- back to state zero if sw went back to '0'
                    state_nxt <= zero;
                else -- but if still when at m_tick, go to next wait state
                    if (m_tick='1') then
                        state_nxt <= wait1_2;
                     end if;
                end if;
            when wait1_2 =>
                if ( sw='0' ) then -- back to state "zero" if sw went back to '0'
                    state_nxt <= zero;
                else -- but if still '1' when at m_tick, go to next wait state
                    if (m_tick='1') then
                        state_nxt <= wait1_3;
                     end if;
                end if;
            when wait1_3 =>
                if ( sw='0' ) then -- back to state zero if sw went back to '0'
                    state_nxt <= zero;
                else -- but if still '1' when at m_tick, go to state "one" (we are done debouncing rising  edge)
                    if (m_tick='1') then
                        state_nxt <= one;
                     end if;
                end if;
            -- sw is one and we are debouncing a falling edge
            -- In the meantime, since SW is one, output must be '1'
            when one =>
                db <= '1';
                if ( sw='0' ) then  -- advance to first wait state when sw=0
                    state_nxt <= wait0_1;
                end if; 
            when wait0_1 =>
                db <= '1';
                if ( sw='1' ) then -- back to state "one" if sw goes back to '1'
                    state_nxt <= one;
                else -- but if still '0' when at m_tick, go to next wait state
                    if (m_tick='1') then
                        state_nxt <= wait0_2;
                     end if;
                end if;
            when wait0_2 =>
                db <= '1';
                if ( sw='1' ) then -- back to state "one" if sw goes back to '1'
                    state_nxt <= one;
                else -- but if still '0' when at m_tick, go to next wait state
                    if (m_tick='1') then
                        state_nxt <= wait0_3;
                     end if;
                end if;
            when wait0_3 =>
                db <= '1';
                if ( sw='1' ) then -- back to state "one" if sw goes back to '1'
                    state_nxt <= one;
                else -- but if still '0' when at m_tick, go to state 'zero' (we are done debouncing falling edge)
                    if (m_tick='1') then
                        state_nxt <= zero;
                     end if;
                end if;            
            --when others => -- not needed because we put default values
        end case; 
    end process;

end scheme1_arch;
