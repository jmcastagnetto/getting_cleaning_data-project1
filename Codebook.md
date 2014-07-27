## Tidy data codebook

### Subject identifier

- subject_id
    - Integer value in the range [1, 30]
    
### Activity

- activity
    - A string describing the assigned activity
        - WALKING
        - WALKING UPSTAIRS
        - WALKING DOWNSTAIRS
        - SITTING
        - STANDING
        - LAYING

### Time Domain Measurements

Time components of the accelerometer and gyroscope raw 3-axial signals
that were:

- Sampled at a constant rate of 50 Hz
- Filtered using a median filter and a 3rd order low pass Butterworth
  filter with a corner frequency of 20 Hz to remove noise. 
- Separated into body and gravity acceleration signals using another
  low pass Butterworth filter with a corner frequency of 0.3 Hz.
- Body linear acceleration and angular velocity were derived in time
  to obtain Jerk signals.
- The magnitude of these three-dimensional signals were calculated
  using the Euclidean norm

All are numeric values in the range [-1, 1]

#### Accelerometer (Body components)

Means (mean) and standard deviations (std) for accelerometer measures
in the X, Y and Z axis

- TimeDomain_Body_Accelerometer_mean_X
- TimeDomain_Body_Accelerometer_mean_Y
- TimeDomain_Body_Accelerometer_mean_Z
- TimeDomain_Body_Accelerometer_std_X
- TimeDomain_Body_Accelerometer_std_Y
- TimeDomain_Body_Accelerometer_std_Z

Means (mean) and standard deviations (std) for accelerometer measures
for jerk movements in the X, Y and Z axis

- TimeDomain_Body_Accelerometer_Jerk_mean_X
- TimeDomain_Body_Accelerometer_Jerk_mean_Y
- TimeDomain_Body_Accelerometer_Jerk_mean_Z
- TimeDomain_Body_Accelerometer_Jerk_std_X
- TimeDomain_Body_Accelerometer_Jerk_std_Y
- TimeDomain_Body_Accelerometer_Jerk_std_Z

Means (mean) and standard deviations (std) for accelerometer magnitudes
and for jerk movement magnitude

- TimeDomain_Body_Accelerometer_Magnitude_mean
- TimeDomain_Body_Accelerometer_Magnitude_std
- TimeDomain_Body_Accelerometer_Jerk_Magnitude_mean
- TimeDomain_Body_Accelerometer_Jerk_Magnitude_std

#### Accelerometer (Gravity components)

Means (mean) and standard deviations (std) for accelerometer measures
in the X, Y and Z axis

- TimeDomain_Gravity_Accelerometer_mean_X
- TimeDomain_Gravity_Accelerometer_mean_Y
- TimeDomain_Gravity_Accelerometer_mean_Z
- TimeDomain_Gravity_Accelerometer_std_X
- TimeDomain_Gravity_Accelerometer_std_Y
- TimeDomain_Gravity_Accelerometer_std_Z

Mean (mean) and standard deviation (std) for accelerometer magnitude

- TimeDomain_Gravity_Accelerometer_Magnitude_mean
- TimeDomain_Gravity_Accelerometer_Magnitude_std

#### Gyroscope (Body components)

Means (mean) and standard deviations (std) for gyroscope measures in
the X, Y and Z axis

- TimeDomain_Body_Gyroscope_mean_X
- TimeDomain_Body_Gyroscope_mean_Y
- TimeDomain_Body_Gyroscope_mean_Z
- TimeDomain_Body_Gyroscope_std_X
- TimeDomain_Body_Gyroscope_std_Y
- TimeDomain_Body_Gyroscope_std_Z

Means (mean) and standard deviations (std) for gyroscope measures for
jerk movements in the X, Y and Z axis

- TimeDomain_Body_Gyroscope_Jerk_mean_X
- TimeDomain_Body_Gyroscope_Jerk_mean_Y
- TimeDomain_Body_Gyroscope_Jerk_mean_Z
- TimeDomain_Body_Gyroscope_Jerk_std_X
- TimeDomain_Body_Gyroscope_Jerk_std_Y
- TimeDomain_Body_Gyroscope_Jerk_std_Z

Means (mean) and standard deviations (std) for gyroscope magnitudes
and for jerk movement magnitude

- TimeDomain_Body_Gyroscope_Magnitude_mean
- TimeDomain_Body_Gyroscope_Magnitude_std
- TimeDomain_Body_Gyroscope_Jerk_Magnitude_mean
- TimeDomain_Body_Gyroscope_Jerk_Magnitude_std

### Frequency Domain Measurements

Frequency components of the accelerometer and gyroscope obtained from
applying a FFT (Fast Fourier Transform) to all the calculated time
domain signals described above.

All are numeric values in the range [-1, 1]

#### Accelerometer (Body components)

Means (mean) and standard deviations (std) for the FFT of the
accelerometer measures in the X, Y and Z axis

- FrequencyDomain_Body_Accelerometer_mean_X
- FrequencyDomain_Body_Accelerometer_mean_Y
- FrequencyDomain_Body_Accelerometer_mean_Z
- FrequencyDomain_Body_Accelerometer_std_X
- FrequencyDomain_Body_Accelerometer_std_Y
- FrequencyDomain_Body_Accelerometer_std_Z

Means (mean) and standard deviations (std) for the FFT of the
accelerometer measures for jerk movements in the X, Y and Z axis

- FrequencyDomain_Body_Accelerometer_Jerk_mean_X
- FrequencyDomain_Body_Accelerometer_Jerk_mean_Y
- FrequencyDomain_Body_Accelerometer_Jerk_mean_Z
- FrequencyDomain_Body_Accelerometer_Jerk_std_X
- FrequencyDomain_Body_Accelerometer_Jerk_std_Y
- FrequencyDomain_Body_Accelerometer_Jerk_std_Z

Means (mean) and standard deviations (std) for he FFT of accelerometer
magnitudes and for jerk movement magnitude

- FrequencyDomain_Body_Accelerometer_Magnitude_mean
- FrequencyDomain_Body_Accelerometer_Magnitude_std
- FrequencyDomain_Body_Accelerometer_Jerk_Magnitude_mean
- FrequencyDomain_Body_Accelerometer_Jerk_Magnitude_std

#### Gyroscope (Body components)

Means (mean) and standard deviations (std) for the FFT of gyroscope
measures in the X, Y and Z axis

- FrequencyDomain_Body_Gyroscope_mean_X
- FrequencyDomain_Body_Gyroscope_mean_Y
- FrequencyDomain_Body_Gyroscope_mean_Z
- FrequencyDomain_Body_Gyroscope_std_X
- FrequencyDomain_Body_Gyroscope_std_Y
- FrequencyDomain_Body_Gyroscope_std_Z

Means (mean) and standard deviations (std) for the FFT of gyroscope
magnitudes and for jerk movement magnitude

- FrequencyDomain_Body_Gyroscope_Magnitude_mean
- FrequencyDomain_Body_Gyroscope_Magnitude_std
- FrequencyDomain_Body_Gyroscope_Jerk_Magnitude_mean
- FrequencyDomain_Body_Gyroscope_Jerk_Magnitude_std