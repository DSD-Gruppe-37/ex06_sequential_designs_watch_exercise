LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

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
    SIGNAL SpeedSelector : INTEGER;
    SIGNAL ClkDivCount   : unsigned(31 DOWNTO 0) := (OTHERS => '0'); -- For clock divisons.
    SIGNAL clkCounter    : unsigned(9 DOWNTO 0)  := (OTHERS => '0'); -- Output Counter
    SIGNAL ClkDiv        : std_logic             := '0';             -- Positive vs negative period

BEGIN

    ClockDivider : PROCESS (clk, speed, reset)
    BEGIN
        -- speed selection 
        CASE (speed) IS
            WHEN '1'    => speedSelector    <= 100e6;
            WHEN '0'    => speedSelector    <= 50e6;
            WHEN OTHERS => speedSelector <= 100e6;
        END CASE;

        -- Timing setup
        IF rising_edge(clk) THEN
            IF (to_integer(unsigned(ClkDivCount)) >= speedSelector) THEN -- 50MHz / 50e6 = 1Hz ? 50MHz / 100e6 = 0.5Hz ?  
                ClkDivCount <= (OTHERS => '0');                              -- reset input
                ClkDiv      <= '1';                                          -- enable clock coutput
            END IF;
        ELSE
            ClkDivCount <= ClkDivCount + 1; -- increase counter -
            ClkDiv      <= '0';             -- set clock ability to 0 
        END IF;

        -- Clocking part
        IF rising_edge(clk) THEN
            IF (ClkDiv <= '1') THEN
                clkCounter <= clkCounter + 1; -- Increase clock
            END IF;
        END IF;

        -- reset part
        IF (reset = '0') THEN
            ClkDivCount <= (OTHERS => '0');
        END IF;

    END PROCESS ClockDivider;
    clk_out <= ClkDiv;
END ARCHITECTURE ClockDivider;