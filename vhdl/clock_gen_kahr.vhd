LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY clock_gen IS
    PORT (
        clk, reset, speed : IN std_logic;
        clk_out : OUT std_logic;
    );
END ENTITY clock_gen;

ARCHITECTURE behaviour OF clock_gen IS
    SIGNAL counter : INTEGER := 0;
    SIGNAL counterMax : INTEGER;
BEGIN
    CASE speed IS
        WHEN '0' => counterMax <= 250e3; -- pulse every 5ms (0.005s * 50MHz)
        WHEN '1' => counterMax <= 50e6; -- pulse every 1s (1s * 50MHz)
    END CASE;

    PROCESS (clk, reset)
    BEGIN
        IF reset = '0' THEN
            counter <= 0;
        ELSIF rising_edge(clk) THEN
            counter = counter + 1;
        END IF;
    END PROCESS;

    IF counter >= counterMax THEN
        clk_out <= '1';
    ELSE
        clk_out <= '0';
    END IF;
END ARCHITECTURE;