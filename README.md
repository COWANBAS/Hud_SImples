Script que adiciona um simples hud da barra de vida fome e sanidade no Don't Starve together adaptado para rodar no Linux.

# Inicio do mod

if GetModConfigData("enablecustomcolor") == true and GetModConfigData("makerainbow") ~= true then
    ...
end

Se a configuração do mod "enablecustomcolor" estiver ativada e o modo "arco-íris" desativado, ele:

- Lê as cores personalizadas (ccred, ccgreen, ccblue);
- Aplica essa cor a todos os elementos da HUD (números e setas dos medidores).

Essas configurações vêm das opções do mod configuráveis no menu.

<img width="784" height="345" alt="image" src="https://github.com/user-attachments/assets/b2a7ce30-a4da-4e61-83b7-4204dba103aa" />

# Rainbow mode

Quando o modo arco-íris está ativo:

- Cria uma cor RGB inicial aleatória;
- A cada “tick” (atualização), altera levemente os valores R, G e B, oscilando entre 0.2 e 0.9;
- Isso gera um efeito contínuo de mudança de cor, aplicado aos números e setas dos medidores (badges).

<img width="793" height="327" alt="image" src="https://github.com/user-attachments/assets/06b387db-0589-4e80-824d-8c854eeb1eff" />

# Modificações nos badges (ícones de status: fome, sanidade, etc.)

O script redefine os métodos padrão da classe "Badge" (widgets usados na HUD):

# OnLoseFocus e OnGainFocus

- Alternam entre num (número principal) e num2 (número secundário).
- Mostram ou escondem números dependendo de qual elemento está em foco (por exemplo, quando o jogador passa o mouse).

# SetPercent

- Atualiza o número mostrado no medidor.
- Aplica cores configuradas (ou arco-íris, se ativo).
- Se "enableadapttopcolor" estiver ativo, muda a cor conforme o valor atual (verde, amarelo, laranja, vermelho).
- Adiciona a numeração máxima.
- Ajusta a cor das setas de sanidade, movendo-as e colorindo-as conforme a direção (aumentando ou diminuindo).

# Modificação no relógio

Adiciona a exibição da temperatura do jogador no relógio da HUD.

- Mostra a temperatura atual em Celsius ou Fahrenheit ("finstead" define o modo).
- Atualiza continuamente o texto.
- Aplica as cores personalizadas ou o efeito arco-íris, conforme configurado.

<img width="1677" height="653" alt="image" src="https://github.com/user-attachments/assets/703c8377-c2fd-4fc9-b9b6-f1a287529aa7" />

# Modificação no medidor de chuva (MoistureMeter)

Modifica o comportamento do medidor de umidade (rain meter):

- Mostra ou esconde o número conforme o foco.
- Aplica cores configuradas ou efeito arco-íris.
- Usa o mesmo estilo visual dos outros badges.

<img width="1651" height="662" alt="image" src="https://github.com/user-attachments/assets/10d2fd3c-41f1-4b94-8fa3-aed4992b9e9b" />

# RESUMO

Esse script personaliza a interface HUD do jogador alterando as cores, comportamento e exibição de informações (como temperatura e umidade), permitindo efeitos visuais como cores customizadas, adaptativas ou animadas em arco-íris, e foi completamente adptado para rodar no linux.

<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/867d690a-44a1-488e-b576-1b52ef347143" />








