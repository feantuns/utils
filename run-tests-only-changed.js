const { execSync } = require("child_process");

// Função para executar comandos de terminal e lidar com erros
function execCommand(command) {
  try {
    console.log(`Executando: ${command}`);
    const output = execSync(command, { encoding: "utf-8" });
    console.log(`Saída do comando: ${output}`);
    return output;
  } catch (error) {
    console.error(`Erro ao executar o comando: ${error.message}`);
    console.error(`Saída do erro: ${error.stdout}`);
    process.exit(1);
  }
}

// Diretório base para verificar alterações
const BASE_DIR = "src";

// Obtém a lista de pastas modificadas na branch atual
const getModifiedDirsCommand = `git diff --name-only origin/master...HEAD | grep "^${BASE_DIR}" | xargs -I {} dirname {} | sort | uniq`;
let modifiedDirs;
try {
  const modifiedDirsOutput = execCommand(getModifiedDirsCommand);
  modifiedDirs = modifiedDirsOutput.trim().split("\n").filter(Boolean); // Remove linhas vazias
} catch (error) {
  console.error("Falha ao obter diretórios modificados:", error);
  process.exit(1);
}

// Verifica se há diretórios modificados
if (modifiedDirs.length > 0) {
  console.log("Diretórios modificados encontrados:");
  console.log(modifiedDirs.join("\n"));

  // Inicializa uma variável para armazenar arquivos de teste modificados
  let testFiles = [];

  // Itera sobre os diretórios modificados
  modifiedDirs.forEach(dir => {
    // Encontrar arquivos de teste modificados na pasta específica
    const findTestFilesCommand = `find ${dir} -type f -name "*.test.tsx"`;
    let changedTestFiles;
    try {
      const changedTestFilesOutput = execCommand(findTestFilesCommand);
      changedTestFiles = changedTestFilesOutput
        .trim()
        .split("\n")
        .filter(Boolean); // Remove linhas vazias
    } catch (error) {
      console.error(`Falha ao encontrar arquivos de teste em ${dir}:`, error);
      return;
    }

    if (changedTestFiles.length > 0) {
      console.log(`Arquivos de teste modificados em ${dir}:`);
      console.log(changedTestFiles.join("\n"));

      // Adiciona os arquivos de teste à lista
      testFiles = testFiles.concat(changedTestFiles);
    }
  });

  // Verifica se há arquivos de teste a serem executados
  if (testFiles.length > 0) {
    console.log("Executando testes para os arquivos:");
    console.log(testFiles.join(" "));

    // Cria um arquivo temporário com os arquivos de teste
    const testFilesPath = "testFiles.txt";
    execCommand(`ls ${testFilesPath} && rm ${testFilesPath} || true`); // Remove o arquivo se existir
    execCommand(`echo "${testFiles.join("\n")}" > ${testFilesPath}`);

    // Executa o comando de teste com arquivos específicos
    const testCommand = `npm run test:ci -- --testPathPattern="${testFiles.join(
      "|"
    )}"`;
    try {
      execCommand(testCommand);
    } catch (error) {
      console.error("Erro ao executar os testes:", error);
      process.exit(1);
    } finally {
      // Remove o arquivo temporário
      execCommand(`rm ${testFilesPath}`);
    }
  } else {
    console.log(
      "Nenhum arquivo de teste encontrado para os diretórios modificados."
    );
  }
} else {
  console.log("Nenhum diretório modificado encontrado.");
}
