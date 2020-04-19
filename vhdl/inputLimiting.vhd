LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY inputLimiting IS
    PORT
    (
        -- inputs
        bin_min1   : IN std_logic_vector(3 DOWNTO 0)
        bin_min10  : IN std_logic_vector(3 DOWNTO 0)
        bin_hrs1   : IN std_logic_vector(3 DOWNTO 0)
        bin_hrs10  : IN std_logic_vector(3 DOWNTO 0)
        ---- Output
        time_alarm : OUT std_logic_vector(15 DOWNTO 0)

    );
END ENTITY inputLimiting;

ARCHITECTURE rtl OF inputLimiting IS
    SIGNAL bin_min1signal  : std_logic_vector(3 DOWNTO 0);
    SIGNAL bin_min10signal : std_logic_vector(3 DOWNTO 0);
    SIGNAL bin_hrs1signal  : std_logic_vector(3 DOWNTO 0);
    SIGNAL bin_hrs10signal : std_logic_vector(3 DOWNTO 0);
BEGIN

    minutLimiting : PROCESS (bin_min1, bin_min10)
    BEGIN
        IF (bin_min1 >= "1001") THEN
            bin_min1signal <= "1001"
                ELSE
                bin_min1signal <= bin_min1;
        END IF;

        IF (bin_min10 >= "0101") THEN
            bin_min10signal <= "0101"
                ELSE
                bin_min10signal <= bin_min10;
        END IF;
    END PROCESS minutLimiting;

    hoursLimiting : PROCESS (bin_hrs1, bin_hrs10)
    BEGIN
        IF (bin_hrs1 >= "1001") THEN
            bin_hrs1signal <= "1001"
                ELSE
                bin_hrs1signal <= bin_hrs1;
        END IF;

        IF (bin_hrs10 >= "0101") THEN
            bin_hrs10signal <= "0101"
                ELSE
                bin_hrs10signal <= bin_hrs10;
        END IF;
    END PROCESS hoursLimiting;
    time_alarm <= (bin_min1signal, bin_min10signal, bin_hrs1signal, bin_hrs10signal);
END ARCHITECTURE rtl;