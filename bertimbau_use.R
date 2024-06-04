# Install necessary packages
install.packages("reticulate")
install.packages("torch")
install.packages("transformers")

library(reticulate)

py_install("transformers")
py_install("torch")

library(reticulate)
transformers <- import("transformers")
torch <- import("torch")

# Load BERTimbau model and tokenizer
tokenizer <- transformers$BertTokenizer$from_pretrained("neuralmind/bert-base-portuguese-cased")
model <- transformers$BertForSequenceClassification$from_pretrained("neuralmind/bert-base-portuguese-cased")

# Example texts (customer reviews)
texts <- c("Eu adorei o produto, muito bom!", "O produto é péssimo, não gostei.")
labels <- c(1, 0)  # 1 for positive, 0 for negative

# Tokenize the texts
inputs <- tokenizer(
  texts,
  return_tensors = "pt",
  padding = TRUE,
  truncation = TRUE,
  max_length = 128
)

# Get model outputs
outputs <- model$forward(inputs)

# Process outputs to get predictions
predictions <- torch$argmax(outputs$logits, dim = 1)

# Print predictions
print(predictions)
