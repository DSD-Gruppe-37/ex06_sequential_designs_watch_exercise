LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;

ENTITY watch_tester IS
  PORT (
    CLOCK_50 : IN std_logic;
    KEY      : std_logic_vector(3 DOWNTO 0);
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    HEX6,
    HEX7 : OUT std_logic_vector(6 DOWNTO 0)
  );
END ENTITY watch_tester;

ARCHITECTURE testbench OF watch_tester IS
BEGIN

  uut : ENTITY watch
    PORT MAP(
      -- INPUTS
      clk   => CLOCK_50,
      speed => KEY(0),
      reset => KEY(3),
      -- OUTPUTS
      sec_1  => HEX2,
      sec_10 => HEX3,
      min_1  => HEX4,
      min_10 => HEX5,
      hrs_1  => HEX6,
      hrs_10 => HEX7,
      tm     => OPEN
    );

END ARCHITECTURE;