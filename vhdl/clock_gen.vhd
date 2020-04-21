LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY clock_gen IS
    PORT
    (
        -- inputs
        clk     : IN std_logic;
        reset   : IN std_logic;
        speed   : IN std_logic;
        -- outputs
        clk_out : OUT std_logic
    );
END ENTITY clock_gen;
ARCHITECTURE ClockDivider OF clock_gen IS

    -- Signals to be used:
    SIGNAL ClkDivCounter : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0'); -- For clock divisons.
    SIGNAL ClkDiv        : std_logic                     := '0';             -- Positive vs negative period

BEGIN
    ClockDivider : PROCESS (clk, reset)
        VARIABLE speedSelector : INTEGER;
    BEGIN
        -- speed selection  
        CASE (speed) IS
            WHEN '0'    => speedSelector    := 25e6; -- 0.5 sec clock   
            WHEN '1'    => speedSelector    := 50e6; -- 1.0 sec clock
            WHEN OTHERS => speedSelector := 100e6;   -- 2.0  sec clock for errors
        END CASE;

        -- reset on speed limit
        IF rising_edge(clk) THEN
            --50MHz clock counting to sel. speed.
            IF (to_integer(unsigned(ClkDivCounter)) >= speedSelector) THEN
                --Reset clock when limit is reached.
                ClkDivCounter <= (OTHERS => '0');
                ClkDiv        <= '1'; --Set output hi
            ELSE
                --Increment - else keep counting
                ClkDivCounter <= std_logic_vector(unsigned(ClkDivCounter) + 1);
                -- with a low output
                ClkDiv        <= '0';
            END IF;

        END IF;
        --hard reset / reset is activated.  
        IF (reset = '0' OR ClkDiv = '1') THEN
            -- reset counter to 0..
            ClkDivCounter <= (OTHERS => '0');
            -- with a low output 
            ClkDiv        <= '0';
        END IF;
    END PROCESS;
    -- assign the generated clock as main clock.
    clk_out <= ClkDiv;
END ARCHITECTURE ClockDivider;