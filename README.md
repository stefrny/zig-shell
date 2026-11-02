# Zig Shell

## Descrição

O Zig Shell é um shell simples desenvolvido na linguagem Zig, como atividade acadêmica.

O projeto implementa um loop de leitura de comandos, execução de programas e retorno ao prompt, permitindo que o usuário interaja com o sistema operacional por meio do terminal.

## Funcionalidades

- Exibição de um prompt interativo (`zig-shell>`).
- Leitura de comandos digitados pelo usuário.
- Execução de programas utilizando `execvp`.
- Busca de executáveis através da variável de ambiente `PATH`.
- Criação de processos filhos utilizando `fork`.
- Espera pelo término dos processos utilizando `waitpid`.
- Retorno ao prompt após a execução dos comandos.
- Tratamento de comandos inexistentes.
- Encerramento do shell através do comando `exit`.
- Suporte a comandos com argumentos, como `ls -l`.

## Tecnologias utilizadas

- Linguagem: Zig
- Versão: Zig 0.16.0
- Sistema operacional: Linux
- Biblioteca C: utilizada para operações de entrada e saída e gerenciamento de processos.

## Estrutura do projeto

```text
zig-shell/
├── main.zig
├── README.md
└── zig-shell
```

## Compilação

Para compilar o projeto, execute:

```sh
mise exec -- zig build-exe main.zig -lc -femit-bin=zig-shell
```

## Execução

Após a compilação, execute:

```sh
./zig-shell
```

## Exemplos de utilização

```text
zig-shell> ls
main.zig   zig-shell

zig-shell> pwd
/home/stefrny/projetos/zig-shell

zig-shell> ls -l

zig-shell> comando_inexistente
Erro ao executar comando: No such file or directory

zig-shell> exit
Encerrando o shell...
```

## Funcionamento

O programa funciona por meio de um loop contínuo que:

1. Exibe o prompt para o usuário.
2. Lê o comando digitado.
3. Separa o comando de seus argumentos.
4. Cria um processo filho utilizando `fork`.
5. Executa o programa solicitado por meio de `execvp`.
6. Aguarda a finalização do processo filho com `waitpid`.
7. Retorna ao prompt para receber um novo comando.

O loop é encerrado quando o usuário digita `exit`.
