library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity project_7_3 is
    Port ( 
          CLK : in std_logic;
          BTN : in std_logic;
          led : out std_logic_vector(7 downto 0);
          C : out std_logic_vector(7 downto 0);
          A : out std_logic_vector(3 downto 0);
          RX : in std_logic  
    );
end project_7_3;

architecture Behavioral of project_7_3 is
signal s_dout : std_logic_vector(7 downto 0);
signal s_feer : std_logic;
signal timer_T : std_logic := '0';
signal err_count : unsigned(13 downto 0) := (others => '0');
signal s_led : std_logic_vector(7 downto 0) := (others => '0');
signal s_valid : std_logic;
begin

-- A <= "1110";
 --led <= s_led;   
    receiver : entity work.UART_receiver
    port map (
        CLK => CLK,
        RST => BTN,
        DOUT => s_dout,
        VALID => s_valid,
        FERR => s_feer,
        RX => RX
    );
        
    test : entity work.project_4_4
    port map (
        CLK => CLK,
        I(13 downto 0) => std_logic_vector(err_count),
        I(31 downto 14) => (others=>'0'),
        MODE => "10",
        C => C,
        A => A
    );
    process (CLK) is    
    begin
        if rising_edge(CLK) then
            if s_feer = '1' then
                err_count <= err_count + 1;               
            end if;        
            if s_valid = '1' then
                led <= s_dout;
            end if;
                
        end if;    
    end process;

end Behavioral;
