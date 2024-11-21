#include <iostream>
#include <filesystem>
#include <fstream>
#include <unordered_set>

void ProcessDirectory(const std::string &path);
void ProcessFile(const std::filesystem::directory_entry &entryFile);

std::unordered_set<std::string> ignored_directories = {
    "app", "bin", "dev", "share", "run", "usr", "etc", "lib", "lib64", "mnt", "opt", "proc", "var", "tmp", "srv", "sys", "sbin", ".vscode", ".local", ".var", ".mozilla", ".eclipse", "virtualenv", ".gradle", ".git", ".config", ".cache", "64E3-8E07", "EFI", ".", "..", "Gradle", "NDK", "Logs", "Application Data", "SendTo", "Recent", "Links", "IntelGraphicsProfiles", "AppData", "venv", "__pycache__", "Library",
};

std::unordered_set<std::string> ignored_file_extensions = {
    ".cache", ".meta", ".mui", ".etl", ".xml", ".log", ".bin", ".msi", ".dat", ".LOG1", ".LOG2", ".ini", ".exe", ".dll", ".url", ".igpi", ".search-ms", ".lnk", ".iso"
};
std::string main_path = "your_main_path_here";
std::string readable = main_path + "/temp/readable_files.txt";
std::ofstream r_files(readable);

int main(int argc, char* argv[]){
    std::string startPath = argv[1];
    try {
        ProcessDirectory(startPath);
    } catch (const std::filesystem::filesystem_error& e) {
        std::cerr << "Error: " << e.what() << std::endl;
    }

    r_files.close();
    return 0;
}

void ProcessDirectory(const std::string& path){
    std::filesystem::path currentPath = path;
    if (ignored_directories.find(currentPath.filename().string()) != ignored_directories.end()) {
        std::cout << currentPath.filename().string() << std::endl;
        return;
    };
    
    for (auto& entry : std::filesystem::directory_iterator(path, std::filesystem::directory_options::skip_permission_denied)) {
        if (entry.is_directory()) {
            ProcessDirectory(entry.path().string());
        } 
        else if (entry.is_regular_file()) {
            ProcessFile(entry);
        }
    }
}

void ProcessFile(const std::filesystem::directory_entry &entryFile){
    if (ignored_file_extensions.find(entryFile.path().extension()) == ignored_file_extensions.end()) {
            r_files <<  entryFile.path() << std::endl;
    }
}