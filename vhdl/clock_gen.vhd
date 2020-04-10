LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY clock_gen IS
    PORT
    (
        clk     : IN std_logic;
        reset   : IN std_logic;
        speed   : IN std_logic;

        clk_out : OUT std_logic
    );
END ENTITY clock_gen;
ARCHITECTURE ClockDivider OF clock_gen IS

    -- Signals to be used:
    SIGNAL ClkDivCounter : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0'); -- For clock divisons.
    SIGNAL clkCounter    : std_logic_vector(9 DOWNTO 0)  := (OTHERS => '0'); -- Output Counter
    SIGNAL ClkDiv        : std_logic                     := '0';             -- Positive vs negative period

BEGIN

    ClockDivMkII : PROCESS (clk, reset)
        VARIABLE SpeedSelector : INTEGER;

    BEGIN
        -- speed selection 
        CASE (speed) IS
            WHEN '0'    => speedSelector    := 10e3; -- 0.5 sec clock
            WHEN '1'    => speedSelector    := 50e6; -- 1.0 sec clock
            WHEN OTHERS => speedSelector := 100e6;   -- 2.0  sec clock for errors
        END CASE;

        -- reset on speed limit
        IF rising_edge(clk) THEN

            IF (ClkDivCounter >= speedSelector) THEN --50MHz clock counting to sel. speed.
                ClkDivCounter <= (OTHERS => '0');        --Reset clock when limit is reached.
                ClkDiv        <= '1';                    --Set output hi
            ELSE
                ClkDivCounter <= ClkDivCounter + 1; --Increment - else keep counting
                ClkDiv        <= '0';               -- with a low output
            END IF;

        END IF;
        -- clock'er
        IF rising_edge(clk) THEN

            IF (ClkDiv = '1') THEN        -- when clockout is high:
                clkCounter <= clkCounter + 1; --Increment the output counter! 
            END IF;

            --hard reset
        ELSIF (reset = '0' OR ClkDiv='1') THEN
            ClkDivCounter <= (OTHERS => '0'); -- reset counter to 0..
            ClkDiv        <= '0';             -- with a low output
        END IF;

    END PROCESS;

    clk_out <= ClkDiv;
END ARCHITECTURE ClockDivider;