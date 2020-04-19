LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; -- used for counting 
USE IEEE.STD_LOGIC_UNSIGNED.ALL;-- used for counting
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
    -- SIGNAL clkCounter    : std_logic_vector(9 DOWNTO 0)  := (OTHERS => '0'); -- Output Counter
    SIGNAL ClkDiv        : std_logic                     := '0';             -- Positive vs negative period

BEGIN

    ClockDivMkII : PROCESS (clk, reset)
        VARIABLE speedSelector : INTEGER;

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
        --hard reset -- 
        IF (reset = '0' OR ClkDiv = '1') THEN
            ClkDivCounter <= (OTHERS => '0'); -- reset counter to 0..
            ClkDiv        <= '0';             -- with a low output
        END IF;

    END PROCESS;
    clk_out <= ClkDiv; -- assign the clock to clock output.
END ARCHITECTURE ClockDivider;

-- ARCHITECTURE behaviour OF clock_gen IS
--     SIGNAL counter    : INTEGER := 0;
--     SIGNAL counterMax : INTEGER;
-- BEGIN
--     PROCESS (clk, reset)
--     BEGIN
--         CASE (speed) IS
--             WHEN '0' => counterMax <= 250e3; -- pulse every 5ms (0.005s * 50MHz)
--             WHEN '1' => counterMax <= 50e6;  -- pulse every 1s (1s * 50MHz)
--         END CASE;
--         IF reset = '0' THEN
--             counter <= 0;
--         ELSIF rising_edge(clk) THEN
--             counter <= counter + 1;
--         END IF;

--         IF (counter >= counterMax) THEN
--             clk_out <= '1';
--         ELSE
--             clk_out <= '0';
--         END IF;
--     END PROCESS;
-- END ARCHITECTURE;