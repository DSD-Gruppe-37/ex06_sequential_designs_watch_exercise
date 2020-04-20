<<<<<<< HEAD

=======
>>>>>>> d6e6a630536b92128e2274364bc6eb0a4ec06fdf
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY buzzing IS
    PORT
    (
        -- input
        tm_watch : IN std_logic_vector(15 DOWNTO 0);
        tm_alarm : IN std_logic_vector(15 DOWNTO 0);
        clk      : IN std_logic;
        -- output
        buzzer   : OUT std_logic
    );
END ENTITY buzzing;
ARCHITECTURE rtl OF buzzing IS

    -- Signals to be used:
    SIGNAL BuzzCount     : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0'); -- For pause counter.
    SIGNAL BuzzFreqCount : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0'); -- For oscilator .
    SIGNAL BuzzOut       : std_logic                     := '0';             -- Positive vs negative period

BEGIN
    BuzzerFreq : PROCESS (tm_watch, tm_alarm, clk)
    BEGIN
        IF (tm_watch = tm_alarm) THEN
            IF rising_edge(clk) THEN
                IF (to_integer(unsigned(BuzzFreqCount)) = 125e3) THEN --50MHz clock counting to 125.000 - 400Hz sqrwave
                    BuzzFreqCount <= (OTHERS => '0');
                    BuzzOut       <= '1'; --Set output hi
                ELSE
                    BuzzFreqCount <= std_logic_vector(unsigned(BuzzFreqCount) + 1); --Increment - else keep counting
                    -- BuzzCount     <= std_logic_vector(unsigned(BuzzCount) + 1);     --Increment - else keep counting
                    BuzzOut       <= '0';                                           -- with a low output
                END IF;
            END IF;
        ELSE
            BuzzOut <= '0';
        END IF;
        buzzer <= BuzzOut;
    END PROCESS BuzzerFreq;
END ARCHITECTURE rtl;