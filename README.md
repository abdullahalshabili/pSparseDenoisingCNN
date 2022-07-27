# Positive Sparse Signal Denoising: What Does a CNN Learn?

## Abstract:
Convolutional neural networks (CNNs) provide impressive empirical success in various tasks; however, their inner workings generally lack interpretability. In this paper, we interpret shallow CNNs that we have trained for the task of positive sparse signal denoising. We identify and analyze common structures among the trained CNNs. We show that the learned CNN denoisers can be interpreted as a nonlinear locally-adaptive thresholding procedure, which is an empirical approximation of the minimum mean square error estimator. Based on our interpretation, we train constrained CNN denoisers and demonstrate no loss in performance despite having fewer trainable parameters. The interpreted CNN denoiser is an instance of a multivariate spline regression model, and a generalization of classical proximal thresholding operators.

## Citation

@article{al2022positive,
  title={Positive sparse signal denoising: What does a CNN learn?},
  author={Al-Shabili, Abdullah H and Selesnick, Ivan},
  journal={IEEE Signal Processing Letters},
  volume={29},
  pages={912--916},
  year={2022},
  publisher={IEEE}
}
