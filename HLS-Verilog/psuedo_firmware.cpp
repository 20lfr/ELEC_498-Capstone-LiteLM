

uint32_t produce_logit(int* token){
    //DO CALC
}

int main(){
    constexpr int D_MODEL = 512;
    int tokens [5][D_MODEL];


    for (int i = 0; i < 5; i++){
        int logit = produce_logit(tokens[i]);
    }

}