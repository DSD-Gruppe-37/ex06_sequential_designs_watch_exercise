LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY compareTime IS
    PORT
    (
        -- input
        tm_watch : IN std_logic_vector(15 DOWNTO 0);
        tm_alarm : IN std_logic_vector(15 DOWNTO 0);
        -- output
        alarm    : OUT std_logic
    );
END ENTITY compareTime;

ARCHITECTURE rtl OF compareTime IS

BEGIN

    Comparison : PROCESS (tm_watch, tm_alarm)
    BEGIN
        IF (tm_watch = tm_alarm) THEN
            alarm <= '1';
        ELSE
            alarm <= '0';
        END IF;
    END PROCESS Comparison;

END ARCHITECTURE rtl;