#include <stdlib.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    char cmd[100];
    int ret;
    char *entrada = argv[1];

    // Execute o primeiro arquivo executável
    sprintf(cmd, "./lexico/lexico %s 0 > saida.txt", entrada);
    ret = system(cmd);

    // Verifique se houve algum erro ao executar o arquivo
    if (ret != 0)
    {
        printf("Erro na análise léxica\n");
        return 1;
    }
    printf("Análise léxica concluída com sucesso\n");

    // Execute o segundo arquivo executável
    ret = system("./sintatico/sintatico.o < saida.txt");

    // Verifique se houve algum erro ao executar o arquivo
    if (ret != 0)
    {
        printf("Erro na análise sintática\n");
        return 1;
    }
    printf("Análise sintática concluída com sucesso\n");

    // Ambos os arquivos executáveis foram executados com sucesso
    return 0;
}
