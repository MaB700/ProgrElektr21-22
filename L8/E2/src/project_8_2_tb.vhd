library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_8_2_tb is
    
end project_8_2_tb;

architecture Behavioral of project_8_2_tb is

constant clk_time : time := 10 ns;
-- sim inputs
signal CLK : std_logic;
signal DIN : std_logic_vector(7 downto 0);
signal DOUT : std_logic_vector(7 downto 0); 
signal WEN : std_logic := '0';
signal REN : std_logic;
-- sim outputs
signal DACK : std_logic;
signal EMPTY : std_logic;
signal FULL : std_logic;
signal OVERFLOW : std_logic;
signal UNDERFLOW : std_logic;
signal DV : std_logic; 

begin
ram : entity work.ram 
  port map( 
        CLK => CLK,
        WEN => WEN,
        DIN => DIN,
        REN => REN,
        DOUT => DOUT,
        -- flags
        DACK => DACK,
        EMPTY => EMPTY,
        FULL => FULL,
        OVERFLOW => OVERFLOW,
        UNDERFLOW => UNDERFLOW,
        DV => DV
  );

    CLK_PROC : process is
        begin
        CLK <= '0';
        wait for clk_time / 2;
        CLK <= '1';
        wait for clk_time / 2;
    end process CLK_PROC;

    Empty_Stack_TB : process is
        begin
        DIN <= "01000001"; -- underflow
        REN <= '1';
        wait for 10 us;
        REN <= '0'; -- overflow
        WEN <= '1';
        DIN <= "01000011";
--        wait for 3 us;
--        WEN <= '0'; -- empty some data from top
--        REN <= '1';
        wait for 3 us;
        REN <= '0'; -- stay at the index
        WEN <= '0';
        wait for 3 us;
        DIN <= "01000111"; -- reading and writing at the same time
        REN <= '1';
        WEN <= '1';
        wait for 3 us;
        REN <= '1';
        WEN <= '0';
        wait for 3 us;
        DIN <= "01001111"; -- reading and writing at the same time
        REN <= '1';
        WEN <= '1';
    end process Empty_Stack_TB;

end Behavioral;
