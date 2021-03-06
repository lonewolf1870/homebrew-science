class Fann < Formula
  homepage "http://leenissen.dk/fann/wp/"
  url "https://downloads.sourceforge.net/project/fann/fann/2.2.0/FANN-2.2.0-Source.tar.gz"
  sha256 "3d6ee056dab91f3b34a3f233de6a15331737848a4cbdb4e0552123d95eed4485"

  option :universal

  depends_on "cmake" => :build

  def install
    ENV.universal_binary if build.universal?
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"xor.data").write <<~EOS
      4 2 1
      -1 -1
      -1
      -1 1
      1
      1 -1
      1
      1 1
      -1
    EOS

    (testpath/"test.c").write <<~EOS
      #include "fann.h"
      int main()
      {
          const unsigned int num_input = 2;
          const unsigned int num_output = 1;
          const unsigned int num_layers = 3;
          const unsigned int num_neurons_hidden = 3;
          const float desired_error = (const float) 0.001;
          const unsigned int max_epochs = 500000;
          const unsigned int epochs_between_reports = 1000;
          struct fann *ann = fann_create_standard(num_layers, num_input,
              num_neurons_hidden, num_output);
          fann_set_activation_function_hidden(ann, FANN_SIGMOID_SYMMETRIC);
          fann_set_activation_function_output(ann, FANN_SIGMOID_SYMMETRIC);
          fann_train_on_file(ann, "xor.data", max_epochs,
              epochs_between_reports, desired_error);
          fann_save(ann, "xor_float.net");
          fann_destroy(ann);
          return 0;
      }
    EOS
    system ENV.cc, "-o", "test", "test.c", "-lfann"
    system "./test"
    system "cat xor_float.net"
  end
end
